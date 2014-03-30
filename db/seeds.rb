require_relative './data_tasks'

# will exit if plan already exists (in any form)
OnceOffTemplateLoad.new.load_template_plan 'Warrandyte Template', '3113'

# plans (by id) to preserve
# WhiteListedDataDestroyer.new.clear_out_all_plans_and_data_except_for_these_plans do
#   (18..30).to_a + [
#     Plan.find_by_name_and_postcode('Warrandyte Template', '3113')
#   ].compact.map(&:id)
# end

# remove all tags from these tasks
Task.find_all_by_id([2973,2974,2975,2976,2977,2978]).each do |t|
  t.tag_list = []
  t.save
end