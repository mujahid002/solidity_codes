// SPDX-License-Identifier: MIT
pragma solidity >=0.8.9;

// Contract to manage attendance
contract AttendanceSheet {
    // Address of the teacher
    address public teacher;

    // Mapping to track attendance of students
    mapping(address => bool) public attendance;

    // Event emitted when attendance is marked
    event MarkAttendance(address student);

    // Constructor function to set the teacher address
    constructor() {
        // Set the teacher address as the deployer of the contract
        teacher = msg.sender;
    }

    // Modifier to restrict access to only the teacher
    modifier onlyTeacher() {
        // Require that the sender is the teacher
        require(msg.sender == teacher, "Only the teacher can mark attendance.");
        _; // Continue with the execution of the marked function
    }

    // Function to mark attendance of a student
    function markAttendance(address student) public onlyTeacher {
        // Mark the attendance of the student as true
        attendance[student] = true;
        // Emit an event to indicate the attendance has been marked
        emit MarkAttendance(student);
    }

    // Function to check the attendance of a student
    function checkAttendance(address student) public view returns (bool) {
        // Retrieve and return the attendance status of the student
        return attendance[student];
    }
}
