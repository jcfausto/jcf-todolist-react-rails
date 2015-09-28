###
TodoApp with Rails and ReacJS
Released under the MIT License
Date: 09-28-2015
Author: Julio Cesar Fausto
Source: https://github.com/jcfausto/jcf-todolist-react-rails
###

@TodoForm = React.createClass
  handleSubmit: (e) ->
    e.preventDefault()
    form = React.findDOMNode(this.refs.todoForm)

    $.ajax
      method: "POST"
      url: "/todos"
      dataType: "JSON"
      data: $(form).serialize()
      success: (data) =>
        this.props.onCreate data
        React.findDOMNode(this.refs.description).value = ""

  render: ->
    `<form onSubmit={this.handleSubmit} ref="todoForm">
      <input name="utf8" type="hidden" value="✓"/>

      <div className="field">
        <input ref="description" type="text" name="todo[description]" id="todo_description" placeholder="I need to..." />
      </div>
    </form>`