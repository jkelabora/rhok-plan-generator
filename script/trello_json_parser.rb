raw = JSON.parse(File.open('/Users/jkelabora/Downloads/automated-bushfire-survival-plan-preparation.json','r').readline)
l = raw['lists']
buckets = l.inject({}){|h,i| h[i['id']] = [];h }
raw['cards'].each{|c| b=buckets[c['idList']]; b << c['name']; b << c['labels']}
buckets


events = [];l.each_with_index{|e,i| events << "event#{i} = Event.create(name: '#{e['name']}')"}