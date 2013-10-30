# Project Gutenberg

Count words in books, and do it fast.

# How to run

Assumes you're using ruby 1.9.3 or above.

    $ ruby gutenberg.rb

# Your project

Build a system that will, given a book, predict which category that book is in.
The allowed categories are: astronomy, philosophy, physics, religion,
archeology.

You build a predictor by extending the `Predict` class and implementing
`Predict#train!` and `Predict#predict` methods.

# Extra challenges
 
## Visualize (easy)

Use a graphics/graphing gem to visualize the word frequencies and any other
thing you think would be useful for understanding the data. Some ideas: word
frequences per book, per category, for all categories. Most popular short
words, long words. Number of words in each book.

## Improve (easy)

Try out different algorithms and see if that would improve your score. Some
ideas:

- What happens if you ignore short words?
- What happens if you ignore long words?
- What happens if you strip out punctuation?
- What happens if you predict a book from a category we don't have? For example:
  a novel from the Fiction category.

## Authorship (moderate)

Instead of applying our algorithm to categories, let's apply it to authors. That
is: can we predict who wrote what, soley based on the words they use?

You'll need to go to gutenberg.org to download some training and test books from
several authors.

A good category is: http://www.gutenberg.org/wiki/Science_Fiction_(Bookshelf)

Some other questions concerning authorship:

- For each author, find their most-used words.
- What words do all authors like to use?


## TF-IDF (hard)

Implement the TF-IDF algorithm to see if that would improve your accuracy.

The main idea behind TF-IDF is that some words in a category are more important
than others. For example: the word "Jesus", coming from the religious category,
probably won't show up in the physics category.

Figure out how to use the TF-IDF formula to train and predict your predictor.

A good paper is: http://www.cs.rutgers.edu/~mlittman/courses/ml03/iCML03/papers/ramos.pdf
