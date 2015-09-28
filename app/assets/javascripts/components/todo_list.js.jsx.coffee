###
TodoApp with Rails and ReacJS
Released under the MIT License
Date: 09-28-2015
Author: Julio Cesar Fausto
Source: https://github.com/jcfausto/jcf-todolist-react-rails
###

@TodoApp = React.createClass
  getInitialState: ->
    todos: this.props.todos

  create: (todo) ->
    this.setState todos: this.state.todos.concat(todo)

  render: ->
    `<div>
      <TodoList todos={this.state.todos} />
      <TodoForm onCreate={this.create} />
    </div>`

@TodoList = React.createClass
  render: ->
    `<ul>
        {this.props.todos.map(
           function(todo, index){
             return (<TodoItem key={index} id={todo.id} description={todo.description} completed_at={todo.completed_at} />)
           }, this)
         }
      </ul>`

@TodoItem = React.createClass

  getInitialState: ->
    {
      description: this.props.description,
      completed: this.props.completed_at?,
      editing: false
    }

  handleClick: (e) ->
    e.preventDefault() 
    this.setState editing: !this.state.editing

  handleChange: ->
    $.ajax(
      method: "PATCH"
      url: "/todos/#{this.props.id}/complete"
      success: =>
        this.setState completed: !this.state.completed
    )

  handleUpdate: (e) ->
    e.preventDefault()
    form = React.findDOMNode(this.refs.todoUpdateForm)
    $.ajax(
      method: "PATCH"
      dataType: "JSON"
      url: "/todos/#{this.props.id}"
      data: $(form).serialize()
      success: (data) =>
        this.setState description: data.description
        this.setState editing: false
    )

  handleBlur: (e) ->
    e.preventDefault()

  handleScapeKey: ->
    this.setState editing: false

  handleKeyDown: (e) ->
    keyCode = e.keyCode

    switch keyCode
      when 27 then this.handleScapeKey()

  render: ->
    if this.state.editing == true
      `<form onSubmit={this.handleUpdate} ref="todoUpdateForm">
        <div className="field">
          <input ref="edit-description" type="text" name="todo[description]" id="todo_description" defaultValue={this.state.description} onBlur={this.handleBlur} onKeyDown={this.handleKeyDown} />
        </div>
      </form>`
    else 
      `<li>
        <input type="checkbox" checked={this.state.completed} onChange={this.handleChange} />
        <label onClick={this.handleClick} >
          {this.state.description}
        </label>
      </li>`

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
