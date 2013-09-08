class HomeController < ApplicationController

  respond_to :json

  def index
    # postcode is provided in params but we'll hard-code to use 3113 for now
    @private_plan_count = Plan.where('public_guid is null').count
    @public_plans = Plan.where('public_guid is not null')
    @task_count = Task.count
    @allocation_count = Allocation.count
    @people_count = Person.count

    @blank_plan = Plan.new
  end

  def visualisation
    # render :json => {
    #   person_id: person.id,
    #   allocations: allocations.collect{|a|
    #     { id: a.id,
    #      name: a.task.name
    #     }
    #   }
    # }.to_json
    render :json => 
    {
       "name" => "root",
       "children" => [
        {"name" => "AggregateExpression", "size" => 1616},
        {"name" => "And", "size" => 1027},
        {"name" => "Arithmetic", "size" => 3891},
        {"name" => "Average", "size" => 891},
        {"name" => "BinaryExpression", "size" => 2893},
        {"name" => "Comparison", "size" => 5103},
        {"name" => "CompositeExpression", "size" => 3677},
        {"name" => "Count", "size" => 781},
        {"name" => "DateUtil", "size" => 4141},
        {"name" => "Distinct", "size" => 933},
        {"name" => "Expression", "size" => 5130},
        {"name" => "ExpressionIterator", "size" => 3617},
        {"name" => "Fn", "size" => 3240},
        {"name" => "If", "size" => 2732},
        {"name" => "IsA", "size" => 2039},
        {"name" => "Literal", "size" => 1214},
        {"name" => "Match", "size" => 3748},
        {"name" => "Maximum", "size" => 843},
        {
         "name" => "methods",
         "children" => [
          {"name" => "add", "size" => 593},
          {"name" => "and", "size" => 330},
          {"name" => "average", "size" => 287},
          {"name" => "count", "size" => 277},
          {"name" => "distinct", "size" => 292},
          {"name" => "div", "size" => 595},
          {"name" => "eq", "size" => 594},
          {"name" => "fn", "size" => 460},
          {"name" => "gt", "size" => 603},
          {"name" => "gte", "size" => 625},
          {"name" => "iff", "size" => 748},
          {"name" => "isa", "size" => 461},
          {"name" => "lt", "size" => 597},
          {"name" => "lte", "size" => 619},
          {"name" => "max", "size" => 283},
          {"name" => "min", "size" => 283},
          {"name" => "mod", "size" => 591},
          {"name" => "mul", "size" => 603},
          {"name" => "neq", "size" => 599},
          {"name" => "not", "size" => 386},
          {"name" => "or", "size" => 323},
          {"name" => "orderby", "size" => 307},
          {"name" => "range", "size" => 772},
          {"name" => "select", "size" => 296},
          {"name" => "stddev", "size" => 363},
          {"name" => "sub", "size" => 600},
          {"name" => "sum", "size" => 280},
          {"name" => "update", "size" => 307},
          {"name" => "variance", "size" => 335},
          {"name" => "where", "size" => 299},
          {"name" => "xor", "size" => 354},
          {"name" => "_", "size" => 264}
         ]
        },
        {"name" => "Minimum", "size" => 843},
        {"name" => "Not", "size" => 1554},
        {"name" => "Or", "size" => 970},
        {"name" => "Query", "size" => 13896},
        {"name" => "Range", "size" => 1594},
        {"name" => "StringUtil", "size" => 4130},
        {"name" => "Sum", "size" => 791},
        {"name" => "Variable", "size" => 1124},
        {"name" => "Variance", "size" => 1876},
        {"name" => "Xor", "size" => 1101}
       ]
      }    
  end

end