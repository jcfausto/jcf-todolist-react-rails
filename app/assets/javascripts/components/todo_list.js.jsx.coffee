###
TodoApp with Rails and ReacJS
Released under the MIT License
Date: 09-28-2015
Author: Julio Cesar Fausto
Source: https://github.com/jcfausto/jcf-todolist-react-rails
###

@TodoList = React.createClass
  render: ->
    `<ul>
        {this.props.todos.map(
           function(todo, index){
             return (<TodoItem key={index} id={todo.id} description={todo.description} completed_at={todo.completed_at} />)
           }, this)
         }
      </ul>`