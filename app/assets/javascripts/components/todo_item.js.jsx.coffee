###
TodoApp with Rails and ReacJS
Released under the MIT License
Date: 09-28-2015
Author: Julio Cesar Fausto
Source: https://github.com/jcfausto/jcf-todolist-react-rails
###

@TodoItem = React.createClass
  
  ## Defining component's propTypes in order to provide a more robust and reusable component.
  propTypes:
    placeholder: React.PropTypes.string,
    description: React.PropTypes.string.isRequired,
    completed: React.PropTypes.bool,
    editing: React.PropTypes.bool

  ## Defining default values for compoent's properties
  getDefaultProps: ->
    {
      placeholder: "I need to do this...",
      description: "I need to do this...", 
      completed: false,
      editing: false
    }

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

  unmount: ->
    node = this.getDOMNode()
    React.unmountComponentAtNode(node)
    $(node).remove()

  handleDelete: (e) ->
    e.preventDefault()
    $.ajax(
      method: "DELETE"
      dataType: "JSON"  
      url: "/todos/#{this.props.id}/"
      success: =>
        this.unmount()
    )

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
          {this.state.description} |&nbsp;
        </label>
        
        <i className="fa fa-trash-o" onClick={this.handleDelete}></i>
      </li>`