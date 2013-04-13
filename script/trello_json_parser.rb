raw = JSON.parse(File.open('/Users/jkelabora/Downloads/automated-bushfire-survival-plan-preparation.json','r').readline)

lists = raw['lists']
buckets = lists.inject({}){|h,i| h[i['id']] = [];h }
# adding in c['labels'] will grab enough data to associate people with tasks
# raw['cards'].each{|c| b=buckets[c['idList']]; b << c['name']; b << c['labels']}
raw['cards'].each{|c| b=buckets[c['idList']]; b << c['name']}
buckets

load = "h = {};".tap do |str|
  lists.each { |e| 
    str << "h['#{e['id']}'] = Event.find_or_create_by_name(name: '#{e['name']}');"
  }
  buckets.each{ |b|
    str << "event = h['#{b[0]}'];"
    b[1].each {|v|
      str << "Task.find_or_create_by_name(name: '#{v}', event_id: event.id);" 
    }
  }
end
