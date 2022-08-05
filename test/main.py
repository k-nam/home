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
    prefix = datetime.now().strftime('%Y%m%d%H%M%S')
    print('prefix is', prefix)
    for n in range(1000*1000):
        id = prefix + '-' + str(n)
        if n % 100 == 0:
            print('now: ',id)
        try:
            insert_table(id)
            create_queue(id)
        except:
            time.sleep(60)



if __name__ == '__main__':
    main()