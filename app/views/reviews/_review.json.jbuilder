json.extract! review, :id, :title, :rating, :review, :recommend, :rated_by, :created_at, :updated_at
json.url review_url(review, format: :json)
