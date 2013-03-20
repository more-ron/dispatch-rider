module DispatchRider
  module QueueServices
    class AwsSqs < Base
      def assign_storage(attrs)
        begin
          AWS::SQS.new.queues.named(attrs.fetch(:name))
        rescue NameError
          raise AdapterNotFoundError.new(self.class.name, 'aws-sdk')
        rescue IndexError
          raise RecordInvalid.new(self, ["Name can not be blank"])
        end
      end

      def enqueue(item)
        queue.send_message(item)
      end

      def get_head
        message = queue.receive_message || OpenStruct.new(:body => nil)
        message.body
      end

      def dequeue
        queue.receive_message.delete
      end

      def size
        queue.approximate_number_of_messages
      end
    end
  end
end