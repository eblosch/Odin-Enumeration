module Enumerable

	def my_each
		return self unless block_given?
		for i in self
			yield i
		end	
	end


	def my_each_with_index
		i = 0
		while i < self.length
			yield self[i], i
			i += 1
		end
	end

	def my_select
		arr = []
		self.my_each do |i|
			arr << i if yield i
		end
		arr
	end

	def my_all?
		self.my_each do |i|
			return false if !(yield i)
		end
		true
	end
	
	def my_any?
		self.my_each do |i|
			return true if (yield i)
		end
		false
	end

	def my_none?
		self.my_each do |i|
			return false if (yield i)
		end
		true
	end

	def my_count
		arr = []
		if block_given? 
			self.my_each { |i| arr << i if yield i }
		else
			arr = self
		end
		arr.length
	end

	def my_map(&code)
		arr = []
		self.my_each do |i|
			arr << (code.call(i))
		end
		arr
	end

	def my_inject(total = self[0])
		self.unshift(self[0]) if total != self[0]
		for i in 1...self.size
			total = yield(total, self[i])
		end
		total
	end

end

def multiply_els(arr)
	arr.my_inject { |product, element| product * element }
end

divide_this = Proc.new { |x| x / 2 }


#[5,28,4].my_each { |x| puts x }
#puts
#[5,28,4].my_each_with_index { |x, i| puts "#{x} at #{i}"}
#puts
#puts [5,28,4].my_select { |x| x % 2 == 0 }
#puts
#puts [17,18,12].my_all? { |x| x < 20 }
#puts
#puts [21,88,92].my_any? { |x| x < 20 }
#puts
#puts [18,88,92].my_none? { |x| x < 20 }
#puts
#puts [18,88,92].my_count { |x| x > 20 }
#puts
#puts [18,88,92].my_map { |x| x / 2 }
#puts
#puts multiply_els([5,7,2])
#puts
#puts [18,88,92].my_map &divide_this
