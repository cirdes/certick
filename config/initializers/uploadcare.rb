class String

  def resize(size)
  	separator = '-/'
  	#http://www.ucarecdn.com/da2c18ce-b89c-4666-855f-370b87e4b335/-/crop/1328x996/332,84/-/resize/400x300/
  	array = self.split(separator)
  	element = array.select { |s| s.include? 'resize' }.first
		array.delete(element)

  	
    case size
    	when :thumb 	then new_w = 35
    	when :small 	then new_w = 100
    	when :medium 	then new_w = 300
    	when :large 	then new_w = 500
    end	

    array << "resize/#{new_w}/"
    array.join(separator)
    
  end
end

class NilClass
  def method_missing *args
    self
  end
end