from concurrent.futures import thread
import threading
import time
import time
import boto3
from datetime import datetime

session = boto3.session.Session(region_name='us-east-1', profile_name='test')
ddbClient = session.client('dynamodb')
sqsClient = session.client('sqs')

def insert_table(id):
    ddbClient.put_item(
        TableName='queue-record',
        Item={
            'user_id': {
                'S': id,
            }
        }
    )

def create_queue(id):
    sqsClient.create_queue(QueueName=id,)

def send_messages(start, range):
    queue_prefix = '20220805090227'
    index = start
    while index < start + range:
        sqsClient.send_message(QueueUrl=f'https://sqs.us-east-1.amazonaws.com/721756646069/{queue_prefix}-{index}', MessageBody='sample message')

        index += 1

def create_many_queues():
    start = datetime.now()
    prefix = start.strftime('%Y%m%d%H%M%S')
    print('prefix is', prefix)
    len = 50
    concurrency = 30

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

def send_many_msgs():
    start_time = datetime.now()
    range = 1000
    end = 100000
    duplicate = 2
    start = 0
    threads = []
    while start + range <= end:
        i = 0
        while i < duplicate:
            t = threading.Thread(target=send_messages,args=(start,range,))
            threads.append(t)
            t.start()
            i += 1
        start += range

    i = 0
    for t in threads:
        t.join()


    end_time = datetime.now()

    print('send message Throughput: ' + str(end*duplicate / (end_time - start_time).total_seconds()) + ' items/sec')

if __name__ == '__main__':
    # create_many_queues()
    send_many_msgs()