# Project Gutenberg

Build a system that will, given a book, predict which category that book is in.
The allowed categories are: astronomy, philosophy, physics, religion,
archeology.

Our algorithm will consist of two parts, training and predicting.

## Training

In training, have access to all the books in `data/training`. Look through the
data for a moment, so you get a feel of what we'll be dealing with.

We have helper methods that loads all the books and converts them to list of tokens (word).

For example, if the sentence is `Jack and Jill went up the hill`, our tokens are
`["jack", "and", "jill", "went", "up", "the", "hill"]`.

An example we've built it found in `SimplePredictor#train!`. Read through this
code and make sure you understand what's happening here.

In short, in training, we build up a data structure `@data` to be used later in
our predict step.

## Predicting

Our predictor will be a method called `predict`. It takes in a list of tokens
and returns a category. For example:

```ruby
my_predictor.predict(["jack", "and", "jill", "went", "up", "the", "hill"])
=> :nursey_rhyme
```

Read through `SimplePredictor#predict` to see how we used the `@data` built in
training to predict the category.

## Running the Program

Let's see how well our `SimplePredictor` does. Run:

    $ ruby gutenberg.rb

And you should get back something like this:

```
+----------------------------------------------------+
| SimplePredictor                                    |
+----------------------------------------------------+
Loading books...
Loading books took 7.048747 seconds.
Training...
Training took 0.000141 seconds.
Predicting...
Predictions took 3.251546 seconds.
Accuracy: 0.4
```

As you can see, our `SimplePredictor` gets 40% of its predictions correct!

## Our Algorithm

`SimplePredict` isn't very smart; we can do better. We're going to implement
`ComplexPredictor`. Now, the algorithm is really up to you. We give you a base
algorithm to use, but feel free to modify the algorithm or try an entirely new
algorithm. Or create multiple algorithms and compare them.

### Training

For our base algorithm, our training will take each category and book and count the number of
occurances of each word, and also the total number of words in each category.
This creates a hash that looks like this:

```ruby
@data = {
  astronomy: {
    counts: {
      "stars" => 100,
      "galaxy" => 80
    },
    total: 180,
  },
  physics: {
    counts: {
      "gravity" => 55,
      "velocity" => 45,
      "energy" => 50
    },
    total: 150,
  }
}
```

In the example above, there may be twenty astronomy books and ten physics books
in our training set, but we add them all up.

### Predicting

Our `predict` function, then, will do a word-frequency comparison. For example,
say we have to predict a book whose content is this:


```
NEWTON'S BOOK ON GRAVITY

by Sir Isaac Newton

I love gravity. Its energy is as numerous as the stars. Gravity.
```

We analyze each token and compare against `@data` like this:

```
matches = {
  astronomy: 0,
  physics: 0
}

for each token in Newton's book:
  for each category:
    if this token is found in the category:
      matches[category] += occurences-of-token-in-category / total-tokens-in-category

return the category in matches with the highest value
```

For Newton's book we would have:

```ruby
matches = {
  astronomy: 0.5555  # 100 / 180        from 1 stars
  physics:   1.0666  # (55+55+50) / 150 from 2 gravity, 1 energy
}
```

And so, for Newton's book, we predict `:physics` since it has the highest score.

### Running ComplexPredictor

Let's see how well our `ComplexPredictor` does. Run:

    $ ruby gutenberg.rb

And you should get back something like this:

```
+----------------------------------------------------+
| ComplexPredictor                                   |
+----------------------------------------------------+
Loading books...
Loading books took 7.116586 seconds.
Training...
Training took 3.0e-06 seconds.
Predicting...
Correct! Predicted astronomy. data/test/astronomy/22157-0.txt.
Correct! Predicted astronomy. data/test/astronomy/8hsrs10u.txt.
Correct! Predicted astronomy. data/test/astronomy/pg16767.txt.
Correct! Predicted astronomy. data/test/astronomy/pg25267.txt.
Correct! Predicted astronomy. data/test/astronomy/pg27477.txt.
Correct! Predicted astronomy. data/test/astronomy/pg28570.txt.
Correct! Predicted astronomy. data/test/astronomy/pg4065.txt.
Wrong.   Predicted astronomy instead of philosophy. data/test/philosophy/11100-0.txt.
Wrong.   Predicted astronomy instead of philosophy. data/test/philosophy/pg13316.txt.
Wrong.   Predicted astronomy instead of philosophy. data/test/philosophy/pg1497.txt.
Wrong.   Predicted astronomy instead of philosophy. data/test/philosophy/pg16712.txt.
Wrong.   Predicted astronomy instead of philosophy. data/test/philosophy/pg22283.txt.
Wrong.   Predicted astronomy instead of philosophy. data/test/philosophy/pg5827.txt.
Wrong.   Predicted astronomy instead of physics. data/test/physics/32857-t.tex.
Wrong.   Predicted astronomy instead of physics. data/test/physics/36525-t.tex.
Wrong.   Predicted astronomy instead of physics. data/test/physics/pg10773.txt.
Wrong.   Predicted astronomy instead of physics. data/test/physics/pg31624.txt.
Wrong.   Predicted astronomy instead of religion. data/test/religion/pg15836.txt.
Wrong.   Predicted astronomy instead of religion. data/test/religion/pg21190.txt.
Wrong.   Predicted astronomy instead of religion. data/test/religion/pg7883.txt.
Wrong.   Predicted astronomy instead of religion. data/test/religion/pg8070.txt.
Wrong.   Predicted astronomy instead of religion. data/test/religion/pg8200.txt.
Wrong.   Predicted astronomy instead of archeology. data/test/archeology/22153-0.txt.
Wrong.   Predicted astronomy instead of archeology. data/test/archeology/pg13575.txt.
Wrong.   Predicted astronomy instead of archeology. data/test/archeology/pg17606.txt.
Wrong.   Predicted astronomy instead of archeology. data/test/archeology/pg17987.txt.
Wrong.   Predicted astronomy instead of archeology. data/test/archeology/pg18931.txt.
Wrong.   Predicted astronomy instead of archeology. data/test/archeology/pg19921.txt.
Wrong.   Predicted astronomy instead of archeology. data/test/archeology/pg23691.txt.
Wrong.   Predicted astronomy instead of archeology. data/test/archeology/pg4248.txt.
Accuracy: 0.23333333333333334
Predictions took 2.78214 seconds.
```

Your accuracy should be higher than 23%, as the above output is from an
algorithm that predicts only `:astronomy`.

### Let's Go

You should have enough information to get started. If you need help, please
don't hesitate to ask an instructor.

# Extra Challenges

In case you didn't have enough fun, here are some ideas on how you could extend
this predictor.

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

# Legal

Copyright Elben Shira
