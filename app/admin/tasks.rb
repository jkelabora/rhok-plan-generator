ActiveAdmin.register Task do
  filter :custom, :as => :select
  filter :tags, :as => :select
  filter :event
  filter :created_at
  filter :updated_at
  filter :name
end
