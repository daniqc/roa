module ContentsHelper
	
    def nested_contents(contents, i=0)
    	contents.map do |content, sub_contents|
          render(:partial =>'courses/content', :locals => {:content => content}) + nested_contents(sub_contents,i+1)
        end.join.html_safe
    end

    def topic_number
    	Content.count(:conditions => "type ='Topic'")
    end
end
