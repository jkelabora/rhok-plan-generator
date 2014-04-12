// http://jon.haslett.id.au/post/37391562488/fixing-the-hover-problem-on-touch-screens-with-feature
if (!("ontouchstart" in document.documentElement)) {
  document.documentElement.className += " no-touch";
}

if ($("#ractive-allocations").length) {
  var Allocations = Ractive.extend({
    el: "ractive-allocations",
    template: "#allocationsTemplate",
    data: {
      plan: gon.plan.plan,
      events: gon.plan.events,
      kits: gon.plan.kits,
      owner: gon.plan.owner,
      plural: function(count) { return (count === 1) ? "" : "s"; }
    },
    init: function() {
      var self = this;

      self.set("selectedEvent", self.get("events.0"));
      self.set("newTask", "");

      self.on("select-event", function(event) {
        self.set("selectedEvent", event.context);
        $.scrollTo(".main-page", 750, {
          'axis':'y'
        });
      });

      self.on("key", function(event) {
        if (event.original.keyCode === 13) {
          self.addTask(event.context.newTask, self);
        }
      });

      self.on("add-task", function(event) {
        self.addTask(event.context.newTask, self);
      });

      self.on("remove-task", function(event) {
        self.removeTask(event.context, event.index.i, self);
      });

      self.on("move-task", function(event) {
        self.moveTask(event.context, event.index.i, self);
      });

      self.on("update-task", function(event) {
        self.updateTask(event.context, event.index.i, self);
      });

      var update_plan_endpoint = '/plans/private/' + self.get("plan.private_guid") + '/update';
      $('.plan-editable .edit-name').editable(update_plan_endpoint, {
        indicator : 'Saving...',
        name      : 'name'
      });

      $('.plan-editable .edit-postcode').editable(update_plan_endpoint, {
        indicator : 'Saving...',
        name      : 'postcode'
      });
    },

    updateTask: function(task, index, self) {
      var update_task_endpoint = '/tasks/' + task.guid + '/update';
      var selector = 'table.allocations td.content.' + index;
      $(selector).editable(update_task_endpoint, {
        indicator : 'Saving...',
        name      : 'name'
      });
    },

    addTask: function(name, self) {
      if (name.trim() !== "") {
        $.ajax({
          type: "POST",
          url: "/tasks/",
          data: {
            name: name,
            event_id: this.get("selectedEvent.event.id"),
            owner_id: this.get("owner.id")
          },
          success: function(data) {
            self.get("selectedEvent.custom_tasks").push(data);
            self.set("newTask", "");
            self.update();
          }
        });
      }
    },

    removeTask: function(task, index, self) {
      $.ajax({
        type: "POST",
        url: "/tasks/" + task.guid,
        data: { "_method": "delete" },
        success: function() {
          var tasks = self.get("selectedEvent.custom_tasks");
          tasks.splice(index, 1);
          self.update();
        }
      });
    },

    moveTask: function(task, index, self) {
      $.ajax({
        type: "POST",
        url: "/tasks/",
        data: { original_guid: task.guid, owner_id: self.get("owner.id") },
        success: function(data) {
          self.get("selectedEvent.custom_tasks").push(data);
          var suggested = self.get("selectedEvent.public_tasks");
          suggested.splice(index, 1);
          self.update();
        }
      });
    }

  });

  var allocations = new Allocations();
}
