package main

import (
	"fmt"
	"sync"
	"time"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/sqs"
)

func getSession() *session.Session {
	region := "us-east-1"
	sess := session.Must(session.NewSessionWithOptions(session.Options{
		SharedConfigState: session.SharedConfigEnable,
		Config:            *aws.NewConfig().WithRegion(region),
	}))
	return sess
}

func sendMsg(client *sqs.SQS, wg *sync.WaitGroup, start int, end int) {
	defer wg.Done()
	queuePrefix := "20220805090227"
	for i := start; i < end; i++ {
		queueUrl := fmt.Sprintf("https://sqs.us-east-1.amazonaws.com/721756646069/%s-%d", queuePrefix, i)
		input := sqs.SendMessageInput{
			QueueUrl:    aws.String(queueUrl),
			MessageBody: aws.String("Test message"),
		}
		_, err := client.SendMessage(&input)
		if err != nil {
			fmt.Printf("%s\n", queueUrl)
			panic(err)
		}
		// fmt.Printf("msgid %s\n", *out.MessageId)
	}
}

func sendManyMsgs() {
	startTime := time.Now()
	interval := 10
	end := 10 * 100
	duplicate := 1
	client := sqs.New(getSession())
	fmt.Println(*client.Config.Region)
	wg := sync.WaitGroup{}

	for start := 0; start+interval <= end; start += interval {
		for i := 0; i < duplicate; i++ {
			// fmt.Printf("Send message start: %d, end: %d\n", start, end)
			wg.Add(1)
			go sendMsg(client, &wg, start, start+interval)
		}
	}
	wg.Wait()
	duration := time.Since(startTime)
	fmt.Printf("# Item: %d, Time: %f\nThrought: %f items / sec", end*duplicate, duration.Seconds(), float64(end*duplicate)/duration.Seconds())
}

func main() {
	sendManyMsgs()
}
