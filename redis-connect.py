import redis
import time

# Redis 클라이언트 연결 (Docker로 실행 중인 Redis 서버에 연결)
r = redis.redis(host='localhost', port=6379, db=0)

# 세션과 같은 데이터 저장 (세션 만료를 위해 TTL 설정)
session_key = 'user_session'
session_value = 'session_data'

# 10초 동안 유효한 세션 설정
r.setex(session_key, 10, session_value)
print(f"세션 저장: {session_key} -> {session_value}")

# 세션 데이터 가져오기
stored_session = r.get(session_key)
if stored_session:
    print(f"세션 데이터: {stored_session.decode()}")  # 디코딩 후 출력
else:
    print("세션이 만료되었거나 존재하지 않습니다.")

# i초마다 출력하며 10초 대기
for i in range(1, 11):
    print(f"{i}초 대기 중...")
    time.sleep(1)

# 10초 후에 세션 만료 확인
expired_session = r.get(session_key)
if expired_session:
    print(f"세션 데이터: {expired_session.decode()}")
else:
    print("세션이 만료되었습니다.")
