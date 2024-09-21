import redis
import time

r = redis.Redis(host='localhost', port=6379, db=0)

channel_name = 'kyu_channel'

# 1초마다 메시지를 'my_channel'로 발행
for i in range(1, 6):
    message = f"from publishing... {i}"
    r.publish(channel_name, message)
    print(f"message: {message}")
    time.sleep(1)
