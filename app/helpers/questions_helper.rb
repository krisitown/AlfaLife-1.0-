module QuestionsHelper
    def count_comments_in_question(question)
        @comments = 0
        main_comments = Comment.where(:question_id => question.id)
        main_comments.each do |main_comment|
            count_comments_in_comment(main_comment)
        end
        return @comments
    end

    def count_comments_in_comment(comment)
        @comments += 1
        main_comments = Comment.where(:comment_id => comment.id)
        main_comments.each do |main_comment|
            count_comments_in_comment(main_comment)
        end
    end
end
