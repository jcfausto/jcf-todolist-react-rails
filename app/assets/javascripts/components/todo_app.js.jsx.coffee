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