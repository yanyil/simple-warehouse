#Simple-Warehouse

A simple command line warehouse management tool. The user can record the storage and removal of crates of variable size on a rack of shelves.

It accepts the following 7 commands:

* `help` - Shows the help message.
* `init W H` - (Re)Initialises the application with a W x H rack of shelves, with all spaces empty.
* `store X Y W H P` - Stores a crate of product code P and of size W x H at position X,Y.
* `locate P` - Show a list of positions where product code P can be found.
* `remove X Y` - Remove the crate at positon X,Y.
* `view` - Show a representation of the current state of the shelves, marking each position as filled or empty.
* `exit` - Exits the application.

## Prerequisites
* Ruby 2.3.1

## Installation
From the command line:
```
$ git clone https://github.com/yyl29/simple-warehouse.git
$ cd simple-warehouse
$ bundle
```

## Usage
To run the app, run from the command line:
```
$ ruby runner.rb
```

Example:
```
> init 4 3
> view
OOOO
OOOO
OOOO
> store 0 1 3 2 P
> view
XXXO
XXXO
OOOO
> store 3 0 1 2 P
> view
XXXO
XXXX
OOOX
> locate P
[0, 1]
[3, 0]
> remove 1 1
> view
OOOO
OOOX
OOOX
> store 4 0 1 1 P
Cannot store crate: position doesn't exist
> store 2 1 2 2 P
Cannot store crate: crate doesn't fit
> remove 0 0
Cannot remove crate: crate doesn't exist
> exit
Thank you for using simple_warehouse!
```

## Test
From the command line:
```
$ ruby test/shelves_spec.rb
```

## Programme design
The app has three classes - the main SimpleWarehouse class (responsible for user input and programme output), Shelves class (for storage and removal of crates) and a Crate class. A 2D array (#state) in the Shelves class represents all the spaces of the shelves, marking each spaces filled or empty. In order to keep track of the positions of the crates stored, each crate is also stored in a 2D array (#positions) at all its filled positions. The crate object itself has a position property (co-ordinates of where it is stored), which is  used for locating the crate.

When storing a crate, the position of the crate is stored at the lower left position. When removing a crate, removing from any positions filled by a crate would remove the corresponding crate.

## Possible improvements
* Extract a Position class from the Shelves class
* Add validation for user input
* Improve error handling 