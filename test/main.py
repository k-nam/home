import threading
import time
import time
import boto3
from datetime import datetime

def insert_table(id):
    s = boto3.session.Session(region_name='us-east-1', profile_name='test')
    ddb = s.client('dynamodb')
    ddb.put_item(
        TableName='queue-record',
        Item={
            'user_id': {
                'S': id,
            }
        }
    )

def create_queue(id):
    s = boto3.session.Session(region_name='us-east-1', profile_name='test')
    q = s.client('sqs')
    q.create_queue(QueueName=id,)


def main():
    start = datetime.now()
    prefix = start.strftime('%Y%m%d%H%M%S')
    print('prefix is', prefix)
    len = 10
    concurrency = 1

    def run(thread_id):
        for n in range(len):
            id = prefix + '-' + str(n) + '-' + thread_id
            if n % 100 == 0:
                print('now: ',id)
            try:
                insert_table(id)
                create_queue(id)
            except:
                time.sleep(60)

    threads = []
    for i in range(concurrency):
        t = threading.Thread(target=run, args=(f'thread-{i}',))
        threads.append(t)
        t.start()

    for i in range(concurrency):
        threads[i].join()

    end = datetime.now()

    print('Throughput: ' + str(len*concurrency / (end - start).total_seconds()) + ' items/sec')

if __name__ == '__main__':
    main()