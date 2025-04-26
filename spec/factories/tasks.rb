FactoryBot.define do
  factory :task do
    title { 'Sample Task' }
    description { 'Task description' }
    status { 'todo' }
    priority { 'medium' }
    association :user
    association :assignee, factory: :user
  end
end