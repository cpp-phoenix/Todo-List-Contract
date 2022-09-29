// SPDX-License-Identifier: MIT

pragma solidity <0.9.0;

contract Todo {

    uint private globalId = 0;

    struct TodoObj {
        string todoText;
        uint id;
    }

    mapping(address => TodoObj[]) private todos;

    function addTodo(string memory _todoText) public {
        address sender = msg.sender;

        if(todos[sender].length > 0) {
            TodoObj[] storage todoList = todos[sender];
            TodoObj memory todoObj = TodoObj(_todoText,globalId);
            todoList.push(todoObj);
        } else {
            TodoObj[] storage todoList = todos[sender];
            todoList.push(TodoObj(_todoText,globalId));
        }

        globalId += 1;
    }

    function getTodos() public view returns (TodoObj[] memory) {
        return todos[msg.sender];
    }

    function updateTodos(uint _id, string memory _todoText) public {
        TodoObj[] storage todoList = todos[msg.sender];
        
        for(uint i=0; i< todoList.length; i++) {
            TodoObj memory todoObj = todoList[i];

            if(todoObj.id == _id) {
                todoObj.todoText = _todoText;
                todoList[i] = todoObj;
                break;
            }
        }
    }

    function deleteTodos(uint _id) public {
        TodoObj[] storage todoList = todos[msg.sender];
        
        for(uint i=0; i< todoList.length; i++) {
            TodoObj memory todoObj = todoList[i];

            if(todoObj.id == _id) {
                delete todoList[i];
                break;
            }
        }
    }
}