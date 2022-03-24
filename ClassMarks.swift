//
// ClassMarks.swift
//
// Created by Ina Tolo
// Created on 2022-3-22
// Version 1.0
// Copyright (c) 2022 Ina Tolo. All rights reserved.
//
// The ClassMarks program implements an application that
// reads a text file into a list, converts it to an array,
// then calls a different functions to randomly generate marks
// for each student in the array.

import Foundation

// function that generates random marks for each student
func generateMarks(studentArray: [String], assignmentsArray: [String]) -> [[String]] {
    // declaring constants
    let assignmentLen: Int = assignmentsArray.count
    let studentLen: Int = studentArray.count

    // declaring variables
    var marks2d = Array(repeating: Array(repeating: "", count: assignmentLen + 1), count: studentLen + 1)

    // adds names of students to the array
    for counterName in 1..<studentArray.count {
        marks2d[counterName][0] = studentArray[counterName - 1]
    }

    // adds marks to each student
    for counterStudents in 1..<assignmentsArray.count {
        for counterMarks in 1..<studentArray.count {
            // https://developer.apple.com/documentation/gameplaykit/gkgaussiandistribution
            let ranMark = Int.random(in: 50...100)
            marks2d[counterMarks][counterStudents].append(String(ranMark))
        }
    }
    return marks2d
}

// main part of the code

// declaring constants
let stuLocation = "/home/ubuntu/ICS4U/Unit1/Unit1-07/Unit1-07-Swift/students.txt/"
let assignLocation = "/home/ubuntu/ICS4U/Unit1/Unit1-07/Unit1-07-Swift/assignments.txt/"
let text = ""

// reads file with student names into array
let studentFile: String = try String(contentsOfFile: stuLocation)
let studentArrayFile: [String] = studentFile.components(separatedBy: "\n")

// reads file with assignments into array
let assignFile: String = try String(contentsOfFile: assignLocation)
let assignmentsArrayFile: [String] = assignFile.components(separatedBy: "\n")

// function call
var markArrayUser: [[String]] = generateMarks(studentArray: studentArrayFile, assignmentsArray: assignmentsArrayFile)

// add the 2D array to a csv file
try text.write(to: URL(fileURLWithPath: "/home/ubuntu/ICS4U/Unit1/Unit1-07/Unit1-07-Swift/marks.csv"),
    atomically: false, encoding: .utf8)
if let fileWriter = try? FileHandle(forUpdating:
    URL(fileURLWithPath: "/home/ubuntu/ICS4U/Unit1/Unit1-07/Unit1-07-Swift/marks.csv")) {
    for array in markArrayUser {
        let arrayToString = array.joined(separator: "       ") + "\n"
        fileWriter.seekToEndOfFile()
        fileWriter.write(arrayToString.data(using: .utf8)!)
    }
    fileWriter.closeFile()
}

print("Marks have been assigned.")
