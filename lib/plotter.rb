require 'gnuplot'

class Plotter
  def plot(best, average, worst)
    Gnuplot.open do |gp|
      Gnuplot::Plot.new(gp) do |plot|

        plot.xrange "[0:#{best.length}]"
        plot.title  'Evolution'
        plot.xlabel 'Generations'
        plot.ylabel 'Fitness'

        plot.data << Gnuplot::DataSet.new(worst) do |ds|
          ds.with = "lines"
          ds.linewidth = 0.5
          ds.title = 'Worst Fitness'
        end

        plot.data << Gnuplot::DataSet.new(average) do |ds|
          ds.with = 'lines'
          ds.linewidth = 1.5
          ds.title = 'Average Fitness'
        end

        plot.data << Gnuplot::DataSet.new(best) do |ds|
          ds.with = 'lines'
          ds.linewidth = 2
          ds.title = 'Best Fitness'
        end
      end
    end
  end
end