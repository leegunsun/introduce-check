

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'PerMissionHandleUtility.dart';

class FcmTokenManager {
  static String? token;
  final Dio _dio = Dio(
      BaseOptions(
          baseUrl: "https://sendpushnotification-tzvcof2hmq-uc.a.run.app"
      )
  );

  static Future<void> init() async {
    int _retryCount = 0;

    PerMissionHandleUtility().requestPermission();

    token = await FirebaseMessaging.instance.getToken();

    while (token == null && _retryCount < 5) {
      token = await FirebaseMessaging.instance.getToken();
      _retryCount++;
    }

    print("🔑 FCM 토큰FCM 토큰: $token");

    // 개선된 토큰 저장 및 확인
    bool success = await createTokenUser();
    if (success) {
      print("✅ FCM 초기화 완료 - 토큰 저장 성공");
    } else {
      print("⚠️ FCM 초기화 완료 - 토큰 저장 실패 (앱은 정상 동작)");
    }
  }

  static Future<bool> createTokenUser() async {
    if (token == null) {
      print("❌ FCM 토큰이 없어서 저장할 수 없습니다");
      return false;
    }

    try {
      print("📤 FCM 토큰 저장 시도: $token");
      
      // 개선된 데이터 구조로 토큰 저장
      await FirebaseFirestore.instance.collection("fcm").doc("master").set({
        "token": token,
        "timestamp": FieldValue.serverTimestamp(),
        "platform": "android"
      });
      
      print("✅ FCM 토큰이 성공적으로 저장되었습니다");
      
      // 저장 확인을 위한 읽기 테스트
      final doc = await FirebaseFirestore.instance.collection("fcm").doc("master").get();
      if (doc.exists && doc.data()?['token'] == token) {
        print("✅ 데이터베이스 저장 확인 완료");
        return true;
      } else {
        print("⚠️ 저장 확인 실패 - 데이터가 일치하지 않음");
        return false;
      }
      
    } on FirebaseException catch (e) {
      print("❌ Firebase 에러: ${e.code} - ${e.message}");
      
      if (e.code == 'permission-denied') {
        print("🔒 Firestore 권한이 거부되었습니다. 보안 규칙을 확인하세요.");
        print("💡 Firebase Console에서 firestore.rules를 배포했는지 확인하세요.");
      }
      
      return false;
    } catch (e) {
      print("❌ 예상치 못한 에러: $e");
      return false;
    }
  }

  // 토큰 저장 상태 확인 메서드 추가
  static Future<void> verifyTokenStorage() async {
    try {
      final doc = await FirebaseFirestore.instance.collection("fcm").doc("master").get();
      
      if (doc.exists) {
        final data = doc.data();
        print("📋 저장된 FCM 데이터:");
        print("   토큰: ${data?['token']}");
        print("   타임스탬프: ${data?['timestamp']}");
        print("   플랫폼: ${data?['platform']}");
      } else {
        print("❌ FCM 문서가 존재하지 않습니다");
      }
    } catch (e) {
      print("❌ FCM 확인 중 에러: $e");
    }
  }

  Future<void> sendTest ({String? title, String? body}) async {

    if(token == null) {
      print("다이나믹 링크 토큰 발생 실패");
      return;
    }

    _dio.post("/",data: {
      "token" : token,
      "title" : title ?? "",
      "body" : body ?? ""
    });
  }
}