Final Project
Compiler’s design
July 27th, 2023

Jonathan de Jesús Chávez Tabares

Professor: Victor Rodríguez

Problem
Smart manufacturing and the rise of intelligent factories, has progressively impacted the mechanics sector. This progression is propelled by the swift evolution of technology and the escalating need for superior products that also offer enhanced efficiency. As a result, the contribution of robots is now indispensable, underscoring the importance of languages used in programming these robots. To confront this necessity, the creation and integration of a reliable compiler for robot languages is crucial.

The purpose of this project is to design and develop a compiler for a robot.

Definition of CFG and Lexemas
The robot compiler uses lexemes, basic language units, including phrases like "Robot", "please", "move", and logical connectors. Symbols "NUMBER" and "ANGLE" represent movement blocks and rotation degrees, respectively. Grammar organizes these lexemes into commands, with each command starting with "Robot, please" and a list of actions. Actions include moving blocks ahead or rotating, defined via a lexeme sequence.

Lexemma Table
Token Description
ROBOT Represents the term "Robot", the subject of the sentences in this programming language.
PLEASE Used for politeness in the programming language. A valid sentence should contain "please".
MOVE Represents the action "move". Used when the robot is commanded to move a certain number of blocks.
BLOCKS The term "blocks" that follows the number in a "move" command. It's the unit of distance the robot moves.
AHEAD The term "ahead". It indicates the direction of the robot's movement.
TURN Represents the action "turn". Used when the robot is commanded to turn a certain number of degrees.
DEGREES The term "degrees" that follows the number in a "turn" command. It's the unit of angle the robot turns.
COMMA Represents a comma. It's used to separate multiple commands within the same sentence.
THEN The term "then". It is used after a comma to connect multiple commands in a polite way.
AND The term "and". It is an alternative to "then" for connecting multiple commands in a polite way.
NUMBER Represents an integer between 1 and 10 inclusive. It specifies the number of blocks the robot should move in a "move" command.
ANGLE Represents a right angle or its multiples (90, 180, 270, 360). It specifies the angle the robot should turn in a "turn" command.
Fig 1. Lexemma Table

Grammar Table
Production Rule Description
COMMAND This represents a full command sequence in our language, which must be polite and specific. It is defined by the rule POLITE_COMMAND.
POLITE_COMMAND A polite command sequence in our language. It is defined as the keyword "Robot", followed by the word "please", and finally an action list, represented by the rule ACTION_LIST.
ACTION_LIST This represents a list of actions that the robot should perform. It can be a single ACTION or multiple actions separated by a comma and the keyword "then".
ACTION This represents a single action that the robot should perform. It can be either a MOVE_ACTION or a TURN_ACTION.
MOVE_ACTION This represents a movement action, where the robot is instructed to move a specific number of blocks ahead. It is defined as the keyword "move", followed by a NUMBER representing the number of blocks to move, the keyword "blocks", and finally the keyword "ahead".
TURN_ACTION This represents a turning action, where the robot is instructed to turn a specific angle. It is defined as the keyword "turn", followed by an ANGLE representing the degree to turn, and finally the keyword "degrees".
Fig 2. Grammar Table

Tests
The following is a set of tests carried out to validate the correctness of the compiler given the specifications before mentioned.

Test Cases
Input Expected result Actual result Reason
Robot move 2 blocks Syntax error Parse error: syntax error There is no ‘please’ in the instruction
Moves Robot 2 blocks and turn 89 degrees Lexical error Unknown character: M ‘Moves’ is not a word in the language
hola robot Lexical error Unknown character: h ‘hola’ is not a word in the language
Robot please move 23 blocks ahead Syntax error Parse error: syntax error 2 and 3 are in the language, but a number cannot follow another
Move 2 blocks right now Lexical error Unknown character: M ‘Move’ (with uppercase) is not in the language
Robot please move 2 blocks ahead MOV,2 MOV,2 -
Robot please move 3 blocks ahead, then turn 90 degrees, then move 2 blocks MOV,3 TURN,90 MOV,2 MOV,3 TURN,90 MOV,2 -
Robot please move 3 blocks ahead and then turn 90 degrees, then move 2 blocks and then move 4 blocks and then move 3 blocks ahead, then turn 180 degrees MOV,3 TURN,90 MOV,2 MOV,4 MOV,3 TURN,180 MOV,3 TURN,90 MOV,2 MOV,4 MOV,3 TURN,180 -
