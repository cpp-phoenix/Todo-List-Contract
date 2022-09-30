// SPDX-License-Identifier: MIT

pragma solidity <0.9.0;

contract TodoList {

    uint private globalId = 0;

    struct Todo {
        string todoText;
        uint id;
    }

    mapping(address => Todo[]) private todos;

    function addTodo(string memory _todoText) public {
        todos[msg.sender].push(Todo(_todoText,globalId));
        globalId += 1;
    }

    function getTodos() public view returns (Todo[] memory) {
        return todos[msg.sender];
    }

    function updateTodos(uint _id, string memory _todoText) public {
        Todo[] storage todoList = todos[msg.sender];
        
        for(uint i=0; i< todoList.length; i++) {
            Todo memory todoObj = todoList[i];

            if(todoObj.id == _id) {
                todoObj.todoText = _todoText;
                todoList[i] = todoObj;
                break;
            }
        }
    }

    function deleteTodos(uint _id) public {
        Todo[] storage todoList = todos[msg.sender];
        
        for(uint i=0; i< todoList.length; i++) {
            Todo memory todoObj = todoList[i];

            if(todoObj.id == _id) {
                delete todoList[i];
                break;
            }
        }
    }
}