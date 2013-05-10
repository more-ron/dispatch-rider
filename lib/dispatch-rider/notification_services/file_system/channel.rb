# this represents a FileSystem queue channel (or basically a folder)

module DispatchRider
  module NotificationServices
    class FileSystem::Channel

      def initialize(path)
        @file_system_queue = DispatchRider::QueueServices::FileSystem::Queue.new(path)
      end

      def publish(message)
        @file_system_queue.add(message.to_json)
      end
    end
  end
end
