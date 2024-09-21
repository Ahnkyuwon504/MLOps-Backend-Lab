from pymilvus import connections, FieldSchema, CollectionSchema, DataType, Collection
import numpy as np

# Milvus에 연결
connections.connect("default", host="localhost", port="19530")

# 벡터 차원 설정
dim = 128

# Collection(테이블) 생성
fields = [
    FieldSchema(name="id", dtype=DataType.INT64, is_primary=True),
    FieldSchema(name="embedding", dtype=DataType.FLOAT_VECTOR, dim=dim)
]
schema = CollectionSchema(fields, "벡터 데이터를 저장하는 컬렉션")

# 컬렉션 생성 (컬렉션 이름: 'example_collection')
collection = Collection("example_collection", schema)

# 벡터 데이터 삽입
vectors = np.random.random((5, dim)).tolist()  # 5개의 랜덤 벡터 생성
ids = [1, 2, 3, 4, 5]
collection.insert([ids, vectors])

# 인덱스 생성 (벡터 검색 속도 향상)
collection.create_index("embedding", {"index_type": "IVF_FLAT", "metric_type": "L2", "params": {"nlist": 10}})

# 컬렉션 로드 (검색을 위해 컬렉션을 메모리에 적재)
collection.load()

# 벡터 검색
search_vectors = np.random.random((1, dim)).tolist()  # 검색할 벡터
results = collection.search(search_vectors, "embedding", param={"nprobe": 10}, limit=2)

# 검색 결과 출력
for result in results:
    print(f"가장 유사한 벡터의 ID: {result.ids}")
