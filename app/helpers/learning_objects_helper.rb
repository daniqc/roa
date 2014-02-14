module LearningObjectsHelper
	def nested_comments(comments, learning_object)
	  comments.map do |comment, sub_comments|
	    render(:partial => "comments/comment", :locals => {:comment => comment, :learning_object => learning_object}) + content_tag(:div, nested_comments(sub_comments, learning_object), :class => "row-fluid nested_comments")
	  end.join.html_safe
	end

	def rating_average(learning_object)
		rating_array = learning_object.ratings.map(&:evaluation)
		if !rating_array.empty?
			av_rating = rating_array.inject{ |sum, el| sum + el }.to_f / rating_array.size
			av_round = av_rating.round
			render :partial => "ratings/star_rating_average", :locals => {:av_rating => av_round, :learning_object => learning_object}
		else
			render :partial => "ratings/star_rating_average", :locals => {:av_rating => 0, :learning_object => learning_object}
		end		
	end
end
