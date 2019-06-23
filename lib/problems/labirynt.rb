require_relative 'base'
require_relative '../individual'
require_relative '../populations/binary'

module Problems
  class Labirynt < Base
    STEPS = 100

    def initialize(population_args)
      @population_args = population_args.merge(problem_population_args)

      super(
        offset: -1 * 20,
        scale: -1 * 20
      )
    end

    def evaluate(individual)
      steps = individual.value
      function(steps, individual)
    end

    def translate(chromossomes)
      decode(chromossomes)
    end

    def new_population
      Populations::Binary.new(self, @population_args).individuals
    end

    def show_variables(steps)
      puts "Steps: #{steps}".yellow
      draw_labyrint(steps)
      puts @result_labyrint.map { |row| row.join(' ') }
      @result_labyrint = nil
    end

    def show_evaluation(individual)
      puts "Evaluation: #{evaluate(individual)} away from destine".yellow
    end

    private

    def start_cell
      [10, 1]
    end

    def end_cell
      [1, 20]
    end

    def labirynt_matrix
      [
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,1,1,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,3,1,1,0,0],
        [0,1,1,1,1,1,1,1,1,0,1,0,1,0,1,0,0,0,0,0,0,0,1,1,0],
        [0,1,0,0,0,0,0,0,1,0,1,0,1,0,1,0,0,0,0,0,0,0,1,0,0],
        [0,1,1,1,1,1,1,0,1,0,1,0,1,0,1,0,1,1,1,0,1,1,1,1,0],
        [0,1,0,0,0,0,1,0,1,0,1,0,1,0,1,0,1,0,0,0,0,0,0,1,0],
        [0,1,0,0,0,0,1,0,1,1,1,1,1,1,1,0,1,1,1,1,1,0,1,1,0],
        [0,1,0,0,0,0,1,0,0,0,0,0,0,0,1,0,1,0,1,0,1,0,0,1,0],
        [0,1,1,1,1,1,1,1,0,1,1,0,1,1,1,0,1,0,1,0,1,0,1,1,0],
        [0,0,0,0,0,0,1,1,0,1,1,0,1,1,1,0,1,0,1,0,1,0,0,1,0],
        [0,2,1,1,1,0,1,0,0,1,1,0,1,0,0,0,1,0,1,0,1,0,1,1,0],
        [0,1,0,0,1,0,1,0,0,1,1,0,1,0,0,0,1,0,1,0,1,1,1,1,0],
        [0,1,0,0,1,0,1,0,0,1,0,0,1,0,0,0,1,0,1,0,0,0,0,1,0],
        [0,1,0,0,1,0,1,1,0,1,0,1,1,1,1,1,1,0,1,0,1,1,1,1,0],
        [0,1,0,0,1,0,1,1,0,1,0,0,0,0,0,0,0,0,1,0,1,0,0,1,0],
        [0,1,1,0,1,0,0,1,1,1,0,0,0,0,0,1,1,1,1,0,1,0,0,1,0],
        [0,1,1,0,1,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0,1,0,1,1,0],
        [0,0,1,0,1,0,1,1,0,0,0,0,0,0,0,1,1,1,1,0,1,0,1,0,0],
        [0,1,1,0,0,0,1,1,0,1,1,1,1,0,0,0,0,0,1,0,1,1,1,1,0],
        [0,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,0,0,1,0],
        [0,0,0,0,1,0,0,0,0,1,1,0,1,1,1,0,1,0,1,0,1,1,0,1,0],
        [0,1,1,1,1,0,1,1,1,1,1,0,1,0,1,0,1,0,1,0,0,1,0,1,0],
        [0,1,1,0,1,0,1,0,0,0,1,0,1,0,1,0,1,0,1,0,1,1,0,1,0],
        [0,1,1,0,1,0,1,0,0,0,1,0,1,0,1,0,1,0,1,0,1,0,0,1,0],
        [0,1,1,0,1,0,1,0,0,0,1,0,1,0,1,0,1,0,1,0,1,1,0,1,0],
        [0,1,1,0,1,0,1,0,0,0,1,0,1,0,1,0,1,0,0,0,0,1,0,1,0],
        [0,0,0,0,1,0,1,1,1,1,1,1,1,1,1,0,1,0,0,1,1,1,1,1,0],
        [0,1,1,1,1,0,1,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,1,0,0],
        [0,1,1,0,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
      ]
    end

    def function(steps,individual)
      step_counter = 0
      good_steps = []
      cells = []
      @cell = start_cell
      old_step = 2
      penality = 0
      steps.each do |step|
        new_cell = walk(step)
        if !valid_cell?(new_cell)
          original_step = step
          step = old_step

          if original_step == old_step
            original_step = step = [(step + 1) % 4, (step + 3) % 4].sample
          end

          new_cell = walk(step)

          if !valid_cell?(new_cell)
            step = (original_step + 2) % 4
            new_cell = walk(step)

            if !valid_cell?(new_cell)
              step = (old_step + 2) % 4
              new_cell = walk(step)
              penality = 10
            end
          end
        end
        @cell = new_cell
        cells << new_cell
        good_steps << step
        step_counter += 1
        return 0 if end_cell?(@cell)

        old_step = step
      end

      individual.chromossomes = encode(good_steps)
      return cell_distance(@cell) + (penality - cell_distance(@cell)/2) if penality
      cell_distance(@cell)
    end

    def draw_labyrint(steps)
      @cell = start_cell
      step_counter = 0
      @result_labyrint = labirynt_matrix.map { |row| row.map { |cell| draw(cell) } }
      steps.each do |step|
        new_cell = walk(step)
        @cell = new_cell
        fill(step_counter)
        step_counter += 1
      end
    end

    def walk(step)
      case step
      when 0 # up
        [@cell[0] - 1, @cell[1]]
      when 1 # right
        [@cell[0], @cell[1] + 1]
      when 2 # down
        [@cell[0] + 1, @cell[1]]
      when 3 # left
        [@cell[0], @cell[1] - 1]
      end
    end

    def valid_cell?(cell)
      cell[0].between?(0, labirynt_matrix.length - 1) &&
      cell[1].between?(0, labirynt_matrix.first.length - 1) &&
      labirynt_matrix[cell[0]][cell[1]] != 0
    end

    def end_cell?(cell)
      labirynt_matrix[cell[0]][cell[1]] == 3
    end

    def cell_distance(cell)
      Math.sqrt(
        (end_cell[0] - cell[0]) ** 2 + (end_cell[1] - cell[1]) ** 2
      )
    end

    def fill(step_counter)
      if step_counter > 99
        counter = step_counter.to_s
      elsif step_counter > 9
        counter = "0#{step_counter}"
      else
        counter = "00#{step_counter}"
      end
      binding.pry if labirynt_matrix[@cell[0]][@cell[1]] == 0
      @result_labyrint[@cell[0]][@cell[1]] = counter.blue
    end

    def draw(cell)
      case cell
      when 0
        'XXX'.red
      when 1
        '   '
      when 2
        'OOO'.blue
      when 3
        'OOO'.green
      end
    end

    def decode(binary)
      steps = []
      binary.each_slice(2) { |a, b| steps << (a.to_s + b.to_s).to_i(2) }
      steps
    end

    def encode(steps)
      steps.map { |step| step.to_s(2).rjust(2, '0').split('').map(&:to_i) }.flatten
    end

    def problem_population_args
      {
        dimensionality: 2*STEPS,
      }
    end
  end
end
