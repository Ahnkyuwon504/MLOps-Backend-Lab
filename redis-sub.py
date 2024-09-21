import redis

r = redis.Redis(host='localhost', port=6379, db=0)

pubsub = r.pubsub()

channel_name = 'kyu_channel'

pubsub.subscribe(channel_name)

print("Subscribing...")

# 메시지를 수신하고 출력
for message in pubsub.listen():
    if message['type'] == 'message':
        print(f"받은 메시지: {message['data'].decode()}")
