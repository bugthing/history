module Orders
  module ReadModels
    class OrderItems
      def self.where(**args)
        Class.new do
          def pluck(column)
            []
          end
        end.new
      end
    end
  end
end
