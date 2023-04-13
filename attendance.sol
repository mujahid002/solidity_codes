// SPDX-License-Identifier: MIT
pragma solidity >=0.8.5;

contract AttendanceSheet {
    address public teacher;
    mapping(address => bool) public attendance;

    event MarkAttendance(address student);

    constructor() {
        teacher = msg.sender;
    }

    modifier onlyTeacher() {
        require(msg.sender == teacher, "Only the teacher can mark attendance.");
        _;
    }

    function markAttendance(address student) public onlyTeacher {
        attendance[student] = true;
        emit MarkAttendance(student);
    }

    function checkAttendance(address student) public view returns (bool) {
        return attendance[student];
    }
}
