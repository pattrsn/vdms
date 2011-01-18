require 'spec_helper'

describe MeetingsScheduler do
  describe MeetingsScheduler::Scheduler do
    describe "instance method: new" do
      it "should create an instnace object of Scheduler" do
        #@scheduler = MeetingsScheduler::Scheduler.new()  
      end 
    end
    
    describe "instance method: make_meetings" do 
    end
    
    describe "class method: create_meetings" do
    end
    
    describe "class method: need_a_new_meeting?" do 
    end
    
    describe "class method: set_up_new_meeting" do 
    end
      
    describe "class method: create_population" do 
    end    
    
  end

  describe MeetingsScheduler::GeneticAlgorithm do
    describe "class method: run" do
    end
  
    describe "class method: selection" do
      it "should select a breed population given a population of chromosomes" do
        #meeting_solution = mock("meeting_solution")
    
        #a dependency issue needs to be fixed
        #@chromosome1 = MeetingsScheduler::Chromosome.new(meeting_solution)
        #@chromosome2 = MeetingsScheduler::Chromosome.new(meeting_solution)
        #@chromosome3 = MeetingsScheduler::Chromosome.new(meeting_solution)
        #@chromosome4 = MeetingsScheduler::Chromosome.new(meeting_solution)
        
        #@chromosome1.stub(:fitness).and_return(50)
        #@chromosome2.stub(:fitness).and_return(55)
        #@chromosome3.stub(:fitness).and_return(40)
        #@chromosome4.stub(:fitness).and_return(35)
      
        #population = [@chromosome1, @chromosome2, @chromosome3, @chromosome4]
        
        
        #MeetingsScheduler::GeneticAlgorithm.stub!(:select_random_individual).and_return(@chromosome3, @chromosome1)
        #breed_population = MeetingsScheduler::GeneticAlgorithm.selection(population)
        #puts breed_population
        #breed_population.count.should == 2
        #breed_population.should == [@chromosome3, @chromosome1]
      end
    end
    
    describe "class method: reproduction" do
      it "should produce a offspring population given a parent population of chromosomes" do
        
        offspring_chromosome1 = mock("mutated_chromosome1", :fitness => 45)
        offspring_chromosome2 = mock("mutated_chromosome2", :fitness => 68)
        offspring_chromosome3 = mock("mutated_chromosome3", :fitness => 79)
        MeetingsScheduler::Chromosome.stub!(:reproduce).and_return(offspring_chromosome1, offspring_chromosome2, offspring_chromosome3)
    
        chromosome1 = mock("chromosome1", :fitness => 50)
        chromosome2 = mock("chromosome2", :fitness => 55)
        chromosome3 = mock("chromosome3", :fitness => 40)
        breed_population = [chromosome1, chromosome2, chromosome3]
      
        offsprings = MeetingsScheduler::GeneticAlgorithm.reproduction(breed_population)
        offsprings.should == [offspring_chromosome1]
      end
    end
        
    describe "class method: mutate_all_population" do
      it "should return a newly mutated population given a population of chromosomes" do
        mutated_chromosome1 = mock("mutated_chromosome1", :fitness => 45)
        mutated_chromosome2 = mock("mutated_chromosome2", :fitness => 68)
        mutated_chromosome3 = mock("mutated_chromosome3", :fitness => 79)
        MeetingsScheduler::Chromosome.stub!(:mutate).and_return(mutated_chromosome1, mutated_chromosome2, mutated_chromosome3)
        
        chromosome1 = mock("chromosome1", :fitness => 50)
        chromosome2 = mock("chromosome2", :fitness => 55)
        chromosome3 = mock("chromosome3", :fitness => 40)
        population = [chromosome1, chromosome2, chromosome3]
        
        mutated_population = MeetingsScheduler::GeneticAlgorithm.mutate_all_population(population)
        mutated_population.should == [mutated_chromosome1, mutated_chromosome2, mutated_chromosome3]
      end    
    end
    
    describe "class method: select_best_chromosome" do
      it "should select the chromosome with fitness 55 when given a population of three chromosomes with fitness 50, 55, and 40" do
        chromosome1 = mock("chromosome1", :fitness => 50)
        chromosome2 = mock("chromosome2", :fitness => 55)
        chromosome3 = mock("chromosome3", :fitness => 40)
      
        population = [chromosome1, chromosome2, chromosome3]
        best_chromosome = MeetingsScheduler::GeneticAlgorithm.select_best_chromosome(population)
        best_chromosome.fitness.should == 55
      end
    end
    
    describe "class method: replace_worst_ranked" do
      it "should replaces the less fit chromosomes in the population by the offspring chromosomes" do
        chromosome1 = mock("chromosome1", :fitness => 50)
        chromosome2 = mock("chromosome2", :fitness => 55)
        chromosome3 = mock("chromosome3", :fitness => 40)
        chromosome4 = mock("chromosome4", :fitness => 35)
  
        offspring_chromosome1 = mock("offspring_chromosome1", :fitness => 60)
        offspring_chromosome2 = mock("offspring_chromosome2", :fitness => 36)
        
        population = [chromosome1, chromosome2, chromosome3, chromosome4]
        offsprings = [offspring_chromosome1, offspring_chromosome2]
        new_population = MeetingsScheduler::GeneticAlgorithm.replace_worst_ranked(population, offsprings)
        
        new_population.should == [chromosome2, chromosome1, offspring_chromosome1, offspring_chromosome2]
      end
    end
    
    describe "class method: select_random_inidividual" do  
      it "should return a randomly selected chromosome given a population of chromosomes" do
        chromosome1 = mock("chromosome1", :fitness => 50, :normalized_fitness => 0.75)
        chromosome2 = mock("chromosome2", :fitness => 55, :normalized_fitness => 1)
        chromosome3 = mock("chromosome3", :fitness => 40, :normalized_fitness => 0.25)
        chromosome4 = mock("chromosome4", :fitness => 35, :normalized_fitness => 0)
        population = [chromosome1, chromosome2, chromosome3, chromosome4]
        accumulated_normalized_fitness = 2
        MeetingsScheduler::GeneticAlgorithm.stub!(:rand).and_return(0.687901)
        
        chromosome = MeetingsScheduler::GeneticAlgorithm.select_random_individual(population, accumulated_normalized_fitness)
        chromosome.should == chromosome2
      end
    end    
  end
   
  describe MeetingsScheduler::MockMeeting do
    before(:each) do
      faculty_id = 15
      schedule_index = 4
      admit_id = 35
      @mock_meeting = MeetingsScheduler::MockMeeting.new(faculty_id, schedule_index, admit_id)
    end
    
    describe "Meeting attributes" do         
      it "has a faculty_id getter method" do 
        @mock_meeting.should respond_to(:faculty_id) 
      end
      
      it "has a faculty_id setter method" do
        @mock_meeting.should respond_to(:faculty_id=)
      end
      
      it "has a schedule_index getter method" do 
        @mock_meeting.should respond_to(:schedule_index) 
      end
      
      it "has a schedule_index setter method" do
        @mock_meeting.should respond_to(:schedule_index=)
      end
      
      it "has an admit_id getter method" do
        @mock_meeting.should respond_to(:admit_id)
      end
      
      it "has an admit_id setter method" do 
        @mock_meeting.should respond_to(:admit_id=) 
      end
      
      it "should have faculty_id = 15, schedule_index = 4, admit_id = 35 when we created a mock_meeting with those values" do
        @mock_meeting.faculty_id.should == 15
        @mock_meeting.schedule_index.should == 4
        @mock_meeting.admit_id.should == 35 
      end 
    end
        
    describe "instance method: faculty_id=" do
      it "should set faculty_id to 25 if we call the setter method faculty_id=25" do
        @mock_meeting.faculty_id = 25
        @mock_meeting.faculty_id.should == 25
      end
    end
        
    describe "instance method: schedule_index=" do
      it "should set schedule_index to 6 if we call the setter method schedule_index=6" do
        @mock_meeting.schedule_index = 6
        @mock_meeting.schedule_index.should == 6
      end
    end
    
    describe "instance method: admit_id=" do
      it "should set admit_id to 46 if we call the setter method admit_id=46" do
        @mock_meeting.admit_id = 46
        @mock_meeting.admit_id.should == 46
      end
    end
  end
  
  describe MeetingsScheduler::MeetingSolution do
    describe "MeetingSolution attributes" do
      before(:each) do
        @meeting_solution = MeetingsScheduler::MeetingSolution.new()
      end
      
      it "has a length method" do
        @meeting_solution.should respond_to(:length)
      end
      
      it "has a add_new_mock_meeting method" do 
        @meeting_solution.should respond_to(:add_new_mock_meeting)
      end
    end
    
    describe "instance method: add_new_mock_meeting" do
      it "has a length 0 before any mock meeting has been added to the meeting solution" do
        @meeting_solution = MeetingsScheduler::MeetingSolution.new()
        @meeting_solution.length.should == 0
      end
            
      it "should add a new MockMeeting object to the meeting solution and increase the length of meeting solution by 1" do
        @meeting_solution = MeetingsScheduler::MeetingSolution.new()
        @mock_meeting = MeetingsScheduler::MockMeeting.new(15, 4, 35)
        @meeting_solution.add_new_mock_meeting(@mock_meeting)
        @meeting_solution.length.should == 1
      end
    end    
  end
  
  
  describe MeetingsScheduler::Chromosome do
    before(:each) do
      @factors_to_consider = create_valid_factors_hash
      MeetingsScheduler::Chromosome.set_factors_to_consider(@factors_to_consider)      
    end

    describe 'Chromosome attributes' do
      before(:each) do
        @number_of_seats = @factors_to_consider[:total_number_of_seats]
        @chromosome = MeetingsScheduler::Chromosome.new()
      end
      
      describe 'instance attribute/method: meeting_solution' do
        it "has a meeting_solution getter method" do
          @chromosome.should respond_to(:meeting_solution)
        end

        it "has a meeting_solution setter method" do
          @chromosome.should respond_to(:meeting_solution=)
        end
      
        it 'should return an Array of Nucleotides' do
          @meeting_solution, solution_str = [], Array.new(@solution_string)
        
          @factors_to_consider[:faculties].each do |faculty_id, faculty|
            faculty[:schedule].each_with_index do |room_timeslot_pair, schedule_index|
              faculty[:max_students_per_meeting].times do
                @meeting_solution << MeetingsScheduler::Nucleotide.new([faculty_id, schedule_index, solution_str.slice!(0)])
              end
            end
          end
          
          @chromosome.meeting_solution.class.should == Array
          @chromosome.meeting_solution.each_with_index do |nucleotide, index|
            nucleotide.==(@meeting_solution[index]).should == true
          end
        end
      end
      
      #describe 'instance attribute/method: solution_string' do
      #  it 'should return an Array encoding a solution of admit_id\'s' do
      #    @chromosome.should respond_to(:solution_string)
      #    @chromosome.solution_string.should == @solution_string
      #    @chromosome.solution_string.each{ |id| (@factors_to_consider[:attending_admits].keys+[nil]).include?(id).should == true }
      #  end
      #end

      describe 'instance attribute/method: normalized_fitness' do
        it 'can be accessed and set for during GA runtime' do
          @chromosome.should respond_to(:normalized_fitness)
          @chromosome.should respond_to(:normalized_fitness=)
        end
      end
     
      describe 'instance method: []' do
        it 'should be able to access and return values from chromosome as an Array' do
          @chromosome.should respond_to(:[])
          @index = rand(@chromosome.length)
          @chromosome[@index].should == @solution_string[@index]
        end
      end
      
      describe 'instance method: solution_string' do
        it 'should return an array of admit_id\'s of each nucleotide along the chromosome' do
          @chromosome.should respond_to(:solution_string)
          @chromosome.solution_string.should == @solution_string
        end
      end
      
      describe 'instance method: length' do
        it 'should return the number of nucleotides in the chromosome' do
          @chromosome.should respond_to(:length)
          @chromosome.length.should == @factors_to_consider[:total_number_of_seats]
        end
      end
      
      describe 'instance method: <=> / ==' do
        it 'should be able to compare the solution_strings (array of admit_id\'s) of each chromosome' do
          @chromosome.should respond_to(:==)
          @chromosome.==(MeetingsScheduler::Chromosome.new(Array.new(@solution_string))).should == true
          @chromosome.==(MeetingsScheduler::Chromosome.new([1, 2, 3])).should == false
        end
      end

      describe 'instance method: fitness' do
        it 'should respond to fitness getter method' do
          @chromosome.should respond_to(:fitness)
        end
        
        it 'should return the sum of the fitness scores of each non-nil nucleotide' do
          @rand_fitness = rand(1000)
          MeetingsScheduler::Chromosome.stub!(:fitness_of_nucleotide).and_return(@rand_fitness)
          @chromosome.fitness.should == @solution_string.delete_if{ |possible_id| possible_id == nil }.count * @rand_fitness
        
        end        
      end
      
      describe 'class method: new/initialize' do
      end


      describe 'class method: mutate' do
        before(:each) do
          @rand = rand
          @chromosome = MeetingsScheduler::Chromosome.new(@factors_to_consider[:total_number_of_seats].times.collect)
          @chromosomal_inversion_probability = @factors_to_consider[:chromosomal_inversion_probability]
          @point_mutation_probability = @factors_to_consider[:point_mutation_probability]
          MeetingsScheduler::Chromosome.stub!(:ok_to_mutate).and_return true
        end

        it 'should choose to invert chromosome #{@chromosomal_inversion_probability*100} % of the time' do
          @rand2 = rand
          MeetingsScheduler::Chromosome.stub!(:pick_two_random_indexes).and_return [@rand, @rand2]
          MeetingsScheduler::Chromosome.stub!(:random).and_return(rand(100*@chromosomal_inversion_probability)/100.0)
          MeetingsScheduler::Chromosome.should_receive(:chromosomal_inversion).once.with(@chromosome, @rand, @rand2)
          MeetingsScheduler::Chromosome.mutate(@chromosome)
        end

        it 'should choose point mutation #{@point_mutation_probability*100} % of the time' do
          MeetingsScheduler::Chromosome.stub!(:random).and_return(rand(100*@point_mutation_probability)/100.0 + @chromosomal_inversion_probability, @rand)
          MeetingsScheduler::Chromosome.should_receive(:point_mutation).once.with(@chromosome, @rand)
          MeetingsScheduler::Chromosome.mutate(@chromosome)
        end

        it "should choose to reverse 2 adjacent sequences as default" do
          MeetingsScheduler::Chromosome.stub!(:random).and_return(rand + @chromosomal_inversion_probability + @point_mutation_probability, @rand)
          MeetingsScheduler::Chromosome.should_receive(:reverse_two_adjacent_sequences).once.with(@chromosome, @rand)
          MeetingsScheduler::Chromosome.mutate(@chromosome)
        end
      end

      describe 'class method: reproduce' do      
        before(:each) do
          @length = @factors_to_consider[:total_number_of_seats]
          @parent1, @parent2 = mock('parent1', :length => @length), mock('parent2', :length => @length)
          @double_crossover_probability = @factors_to_consider[:double_crossover_probability]
        end

        it 'should choose to double crossover #{@double_crossover_probability*100.0}% of the time' do
          @rand1, @rand2 = rand, rand
          MeetingsScheduler::Chromosome.stub!(:random).and_return(rand(100*@double_crossover_probability)/100.0)
          MeetingsScheduler::Chromosome.stub!(:pick_two_random_indexes).and_return [@rand1, @rand2]
          MeetingsScheduler::Chromosome.stub!(:double_crossover)
          MeetingsScheduler::Chromosome.should_receive(:double_crossover).once.with(@parent1, @parent2, @rand1, @rand2)
          MeetingsScheduler::Chromosome.reproduce(@parent1, @parent2)
        end

        it 'should choose to single crossover as default' do
          @rand = rand
          MeetingsScheduler::Chromosome.stub!(:random).and_return(rand + @double_crossover_probability, @rand)
          MeetingsScheduler::Chromosome.stub!(:single_crossover)
          MeetingsScheduler::Chromosome.should_receive(:single_crossover).once.with(@parent1, @parent2, @rand+1)
          MeetingsScheduler::Chromosome.reproduce(@parent1, @parent2)
        end
      end

      describe 'class method: seed' do
        it 'should call create_solution_string to generate an Array of admit_id\'s and pass it to new' do
          @solution_string = mock('solution_string')
          MeetingsScheduler::Chromosome.stub!(:create_solution_string).and_return(@solution_string)
          MeetingsScheduler::Chromosome.should_receive(:create_solution_string).once
          MeetingsScheduler::Chromosome.should_receive(:new).once.with(@solution_string)
          MeetingsScheduler::Chromosome.seed
        end
      end

      describe 'class method: create_solution_string' do
        before(:each) do
          @length = @factors_to_consider[:total_number_of_seats]
          @spots_per_student = @factors_to_consider[:number_of_spots_per_admit]
          @solution_string = MeetingsScheduler::Chromosome.create_solution_string
        end

        it 'should return an Array of admid_id\'s, with the correct length' do
          @solution_string.class.should == Array
          @solution_string.length.should == @length
          @solution_string.delete_if{ |id| id == nil }.each do |possible_id|
            @factors_to_consider[:attending_admits].keys.include?(possible_id).should == true
          end
        end

        it "should return an Array in which there are #{@spots_per_student} copies of each admit_id" do
          @solution_string.uniq.delete_if{ |id| id == nil }.each do |admit_id|
            @solution_string.find_all{ |id| id == admit_id }.length.should == @spots_per_student
          end
        end
      end

      describe 'Fitness function score helper methods' do
        before(:each) do
          @fitness_scores_table = create_valid_fitness_scores_table
          MeetingsScheduler::Chromosome.set_fitness_scores_table(@fitness_scores_table)
        end

        describe 'class method: fitness_of_nucleotide' do
          before(:each) do
            @nucleotide = mock('Nucleotide')
          end
          it 'should return the sum of all fitness criteria subscores of a single nucleotide, if physical arrangement is possible' do
            @randA, @randB, @randC = rand(1000), rand(1000), rand(1000)
            MeetingsScheduler::Chromosome.stub!(:meeting_possible_score).and_return @fitness_scores_table[:meeting_possible_score]
            MeetingsScheduler::Chromosome.stub!(:admit_preference_score).and_return(@randA)
            MeetingsScheduler::Chromosome.stub!(:faculty_preference_score).and_return(@randB)
            MeetingsScheduler::Chromosome.stub!(:area_match_score).and_return(@randC)
            MeetingsScheduler::Chromosome.fitness_of_nucleotide(@nucleotide).should == @fitness_scores_table[:meeting_possible_score] +
              @randA + @randB + @randC
          end
          it 'should just return a penalty for impossible arrangement if physical arrangement described by a single nucleotide is impossible' do
            MeetingsScheduler::Chromosome.stub!(:meeting_possible_score).and_return @fitness_scores_table[:meeting_possible_penalty]
            MeetingsScheduler::Chromosome.fitness_of_nucleotide(@nucleotide).should == @fitness_scores_table[:meeting_possible_penalty]
          end
        end

        describe 'class method: extract_admit_faculty_and_schedule_index' do
          it 'should return an array of an admit\'s hash, the faculty\'s hash, and a schedule_index, given a nucleotide' do
            @faculty_id = @factors_to_consider[:faculties].keys.shuffle.shuffle.fetch(0)
            @admit_id = @factors_to_consider[:attending_admits].keys.shuffle.shuffle.fetch(0)
            @schedule_index = rand(@factors_to_consider[:faculties][@faculty_id][:schedule].length)

            @nucleotide = MeetingsScheduler::Nucleotide.new([@faculty_id, @schedule_index, @admit_id])
            MeetingsScheduler::Chromosome.extract_admit_faculty_and_schedule_index(@nucleotide).should ==
              [@factors_to_consider[:attending_admits][@admit_id], @factors_to_consider[:faculties][@faculty_id], @schedule_index]
          end
        end

        describe 'class method: meeting_possible_score' do
          before(:each) do
            @nucleotide = mock('nucleotide')
            @slots = rand(10)+1
            @schedule = @slots.times.collect{ |num| { :time_slot => (12*num).hours.from_now..(12*num+4).hours.from_now  }}
            @faculty = { :schedule => @schedule }
          end

          it 'should return a score if a meeting arrangement defined by a single nucleotide is physically possible' do
            @schedule_index = rand(@slots)
            @correct_slot = (@schedule[@schedule_index][:time_slot].begin-4.hours)..(@schedule[@schedule_index][:time_slot].end+2.hours)
            @admit = { :available_times => RangeSet.new([@correct_slot]) }
            MeetingsScheduler::Chromosome.stub!(:extract_admit_faculty_and_schedule_index).and_return [@admit, @faculty, @schedule_index]
            MeetingsScheduler::Chromosome.meeting_possible_score(@nucleotide).should == @fitness_scores_table[:meeting_possible_score]
          end

          it 'should return a penalty if a meeting arrangement defined by a single nucleotide is physically impossible' do
            @schedule_index = rand(@slots)          
            @admit = { :available_times => RangeSet.new([4.days.ago..2.days.ago]) }
            MeetingsScheduler::Chromosome.stub!(:extract_admit_faculty_and_schedule_index).and_return [@admit, @faculty, @schedule_index]
            MeetingsScheduler::Chromosome.meeting_possible_score(@nucleotide).should == @fitness_scores_table[:meeting_possible_penalty]
          end        
        end

        describe 'class method: faculty_preference_score' do
          before(:each) do
            @admit, @faculty, @nucleotide = mock('admit'), mock('faculty'), mock('nucleotide')
            MeetingsScheduler::Chromosome.stub!(:extract_admit_faculty_and_schedule_index).and_return [@admit, @faculty, mock('schedule_index')]
          end

          it 'should return a rank-weighted score if a faculty is among an ADMIT\'s ranking' do
            @ranking = { :rank => rand(@factors_to_consider[:number_of_spots_per_admit]) }
            MeetingsScheduler::Chromosome.stub!(:find_faculty_ranking).and_return(@ranking)
            MeetingsScheduler::Chromosome.should_receive(:find_faculty_ranking).once.with(@admit, @faculty)

            MeetingsScheduler::Chromosome.faculty_preference_score(@nucleotide).should ==
              @fitness_scores_table[:faculty_ranking_weight_score] * (@factors_to_consider[:lowest_rank_possible]+1 - @ranking[:rank])
          end

          it 'should return a default score if a faculty is not among an ADMIT\'s ranking' do
            MeetingsScheduler::Chromosome.stub!(:find_faculty_ranking).and_return nil
            MeetingsScheduler::Chromosome.should_receive(:find_faculty_ranking).once.with(@admit, @faculty)

            MeetingsScheduler::Chromosome.faculty_preference_score(@nucleotide).should ==
              @fitness_scores_table[:faculty_ranking_default]
          end        
        end

        describe 'class method: find_faculty_ranking' do
          it 'should return the ADMIT\'s ranking that contains the faculty' do
            @faculty_id = rand(100)
            @faculty = { :id => @faculty_id }
            @ranking = { :faculty_id  => @faculty_id }
            @admit = { :rankings => (rand(20).times.collect{ |id| { :faculty_id => "Non-id #{id}" }} + [@ranking]).shuffle.shuffle }
            MeetingsScheduler::Chromosome.find_faculty_ranking(@admit, @faculty).should == @ranking
          end
        end

        describe 'class method: admit_preference_score' do
          before(:each) do
            @meeting_solution, @admit, @faculty, @nucleotide = mock('meeting_solution'), mock('admit'), mock('faculty'), mock('nucleotide')
            @ranking = { :rank => rand(@factors_to_consider[:number_of_spots_per_admit]) } # should be same as :lowest_rank_possible
            MeetingsScheduler::Chromosome.stub!(:extract_admit_faculty_and_schedule_index).and_return [@admit, @faculty, mock('schedule_index')]
          end

          it 'should compute a rank-weighted score if an admit is among a FACULTY\'s ranking' do
            MeetingsScheduler::Chromosome.stub!(:one_on_one_score).and_return(0)
            MeetingsScheduler::Chromosome.stub!(:mandatory_meeting_score).and_return(0)          
            MeetingsScheduler::Chromosome.stub!(:find_admit_ranking).and_return(@ranking)
            MeetingsScheduler::Chromosome.should_receive(:find_admit_ranking).once.with(@admit, @faculty)

            MeetingsScheduler::Chromosome.admit_preference_score(@meeting_solution, @nucleotide).should ==
              @fitness_scores_table[:admit_ranking_weight_score] * (@factors_to_consider[:lowest_rank_possible]+1 - @ranking[:rank])
          end

          it 'should further compute and add one-on-one and mandatory-meeting scores if an admit is among a FACULTY\'s ranking' do
            @one_on_one_score, @mandatory_meeting_score = rand(20)+1, rand(20)+1
            MeetingsScheduler::Chromosome.stub!(:one_on_one_score).and_return(@one_on_one_score)
            MeetingsScheduler::Chromosome.stub!(:mandatory_meeting_score).and_return(@mandatory_meeting_score)
            MeetingsScheduler::Chromosome.stub!(:find_admit_ranking).and_return(@ranking)

            MeetingsScheduler::Chromosome.should_receive(:one_on_one_score).once.with(@meeting_solution, @nucleotide, @ranking)
            MeetingsScheduler::Chromosome.should_receive(:mandatory_meeting_score).once.with(@ranking)
            MeetingsScheduler::Chromosome.admit_preference_score(@meeting_solution, @nucleotide).should ==
              @fitness_scores_table[:admit_ranking_weight_score] * (@factors_to_consider[:lowest_rank_possible]+1 - @ranking[:rank]) +
              @one_on_one_score + @mandatory_meeting_score
          end

          it 'should return a default score if an admit is not among a FACULTY\'s ranking' do
            MeetingsScheduler::Chromosome.stub!(:find_admit_ranking).and_return nil
            MeetingsScheduler::Chromosome.should_receive(:find_admit_ranking).once.with(@admit, @faculty)
            MeetingsScheduler::Chromosome.admit_preference_score(@meeting_solution, @nucleotide).should ==
              @fitness_scores_table[:admit_ranking_default]
          end
        end

        describe 'class method: find_admit_ranking' do
          it 'should return the FACULTY\'s ranking that contains the admit' do
            @admit_id = rand(100)
            @admit = { :id => @admit_id }
            @ranking = { :admit_id  => @admit_id }
            @faculty = { :rankings => (rand(20).times.collect{ |id| { :admit_id => "Non-id #{id}" }} + [@ranking]).shuffle.shuffle }          
            MeetingsScheduler::Chromosome.find_admit_ranking(@admit, @faculty).should == @ranking
          end
        end

        describe 'class method: area_match_score' do
          it 'should return the appropriate points when a faculty\'s areas of research matches one of an admit\'s areas of interest' do
            @faculty = { :area => 'subjectA' }
            @admit = { :area1 => 'subjectA', :area2 => 'subjectC' }
            MeetingsScheduler::Chromosome.stub!(:extract_admit_faculty_and_schedule_index).and_return [@admit, @faculty, mock('schedule_index')]
            MeetingsScheduler::Chromosome.area_match_score(@nucleotide).should == @fitness_scores_table[:area_match_score]
          end

          it 'should return the appropriate default when a faculty\'s areas of research does not match any one of an admit\'s areas of interest' do
            @faculty = { :area => 'subjectA' }
            @admit = { :area1 => 'subjectB', :area2 => 'subjectC' }
            MeetingsScheduler::Chromosome.stub!(:extract_admit_faculty_and_schedule_index).and_return [@admit, @faculty, mock('schedule_index')]
            MeetingsScheduler::Chromosome.area_match_score(@nucleotide).should == @fitness_scores_table[:area_match_default]
          end
        end

        describe 'class method: one_on_one_score' do        
          before(:each) do
            @meeting_solution, @nucleotide = mock('meeting_solution'), mock('nucleotide')
            @admit, @faculty, @schedule_index = mock('admit'), mock('faculty'), mock('people_in_meeting')
            @people_in_meeting = mock('schedule_index')

            MeetingsScheduler::Chromosome.stub!(:extract_admit_faculty_and_schedule_index).and_return [@admit, @faculty, @schedule_index]
            MeetingsScheduler::Chromosome.stub!(:get_people_in_meeting).and_return(@people_in_meeting)
          end

          it 'should return a score when a FACULTY\'s admit ranking request for one-to-one meeting has been met' do
            @ranking = { :one_on_one => true }
            MeetingsScheduler::Chromosome.stub!(:only_one_person_in_meeting).and_return true
            MeetingsScheduler::Chromosome.should_receive(:only_one_person_in_meeting).once.with(@people_in_meeting, @admit)
            MeetingsScheduler::Chromosome.one_on_one_score(@meeting_solution, @nucleotide, @ranking).should ==
              @fitness_scores_table[:one_on_one_score]
          end

          it 'should return a penalty when a FACULTY\'s admit ranking request for one-to-one meeting has not been met' do
            @ranking = { :one_on_one => true}
            MeetingsScheduler::Chromosome.stub!(:only_one_person_in_meeting).and_return false
            MeetingsScheduler::Chromosome.should_receive(:only_one_person_in_meeting).once.with(@people_in_meeting, @admit)
            MeetingsScheduler::Chromosome.one_on_one_score(@meeting_solution, @nucleotide, @ranking).should ==
              @fitness_scores_table[:one_on_one_penalty]
          end

          it 'should return a default score when a FACULTY\'s admit ranking did not request for a one-to-one meeting' do
            @ranking = { :one_on_one => false}
            MeetingsScheduler::Chromosome.one_on_one_score(@meeting_solution, @nucleotide, @ranking).should ==
              @fitness_scores_table[:one_on_one_default]
          end
        end

        describe 'class method: get_people_in_meeting' do
          it 'should return just a subset of admit_id\'s that are in a specific timeslot for a specific faculty' do
            @length = @factors_to_consider[:total_number_of_seats]
            @meeting_solution = MeetingsScheduler::Chromosome.new(@length.times.collect.shuffle.shuffle).meeting_solution

            @faculty_id = @factors_to_consider[:faculties].keys.shuffle.shuffle.fetch(0)
            @faculty = { :id => @faculty_id }
            @schedule_index = rand(@factors_to_consider[:faculties][@faculty_id][:schedule].count)

            MeetingsScheduler::Chromosome.get_people_in_meeting(@meeting_solution, @faculty, @schedule_index).sort.should ==
              @meeting_solution.find_all{ |n| n.faculty_id == @faculty_id and n.schedule_index == @schedule_index }.collect{ |n| n.admit_id }.sort
          end        
        end

        describe 'class method: only_one_person_in_meeting' do
          before(:each) do
            @admit = { :id => 1 }
          end

          it 'should return true if the admit\'s id is the only unique one in an array of admit_id\'s, excluding nils' do        
            @people_in_meeting = (Array.new(19) + [1]).shuffle.shuffle
            MeetingsScheduler::Chromosome.only_one_person_in_meeting(@people_in_meeting, @admit).should == true
          end

          it 'should return false if the admit\'s id is not the only unique id in an array of admit_id\'s' do
            @people_in_meeting = (Array.new(18) + (1..2).collect).shuffle.shuffle
            MeetingsScheduler::Chromosome.only_one_person_in_meeting(@people_in_meeting, @admit).should == false          
          end

          it 'should return false if the admit\'s id is not in an array of admit_id\'s' do
            @people_in_meeting = (Array.new(19) + [2]).shuffle.shuffle
            MeetingsScheduler::Chromosome.only_one_person_in_meeting(@people_in_meeting, @admit).should == false
          end
        end

        describe 'class method: mandatory_meeting_score' do
          [true, false].each do |val|
            it "should return the appropriate points for whether a FACULTY\'s admit ranking is marked #{val}" do
              @ranking = { :mandatory => val }
              score = val ? @fitness_scores_table[:mandatory_score] : @fitness_scores_table[:mandatory_default]
              MeetingsScheduler::Chromosome.mandatory_meeting_score(@ranking).should == score
            end
          end
        end
      end

      describe 'Reproduction helper methods' do
        before(:each) do
          @length = @factors_to_consider[:total_number_of_seats]
          @parent1 = MeetingsScheduler::Chromosome.new(@length.times.collect.shuffle.shuffle)
          @parent2 = MeetingsScheduler::Chromosome.new(@length.times.collect.shuffle.shuffle)
        end

        describe 'class method: single_crossover' do
          it 'should return a new chromosome with the proper single swap' do
            @splice_index = rand(@length)
            @child = MeetingsScheduler::Chromosome.single_crossover(@parent1, @parent2, @splice_index)
            @child.class.should == MeetingsScheduler::Chromosome
            @child.should == MeetingsScheduler::Chromosome.new(@parent1[0...@splice_index] + @parent2[@splice_index..-1])
          end   
        end

        describe 'class method: double_crossover' do
          it 'should return a new chromosome with the proper double swap' do
            @index1, @index2 = MeetingsScheduler::Chromosome.pick_two_random_indexes(@parent1)
            @child = MeetingsScheduler::Chromosome.double_crossover(@parent1, @parent2, @index1, @index2)
            @child.class.should == MeetingsScheduler::Chromosome
            @child.should == MeetingsScheduler::Chromosome.new(@parent1[0...@index1] + @parent2[@index1...@index2] + @parent1[@index2..-1])
          end
        end
      end

      describe 'Mutation helper methods' do
        before(:each) do
          @length = @factors_to_consider[:total_number_of_seats]
          @chromosome = MeetingsScheduler::Chromosome.new(@length.times.collect.shuffle.shuffle)
        end

        describe 'class method: reverse_two_adjacent_sequences' do                 
          it 'should return a new chromosome with two adjacent sequences reversed, given a chromosome' do
            @index = rand(@length-1)
            @mutant = MeetingsScheduler::Chromosome.reverse_two_adjacent_sequences(@chromosome, @index)
            @mutant.class.should == MeetingsScheduler::Chromosome
            @mutant.==(MeetingsScheduler::Chromosome.new(@chromosome[0...@index] +
                                                         @chromosome[@index..@index+1].reverse + @chromosome[@index+2..-1])).should == true
          end
        end    

        describe 'class method: chromosomal_inversion' do
          it 'should return a new chromosome with proper inversion, given a chromosome' do
            @index1, @index2 = MeetingsScheduler::Chromosome.pick_two_random_indexes(@chromosome)
            @mutant = MeetingsScheduler::Chromosome.chromosomal_inversion(@chromosome, @index1, @index2)
            @mutant.class.should == MeetingsScheduler::Chromosome
            @mutant.==(MeetingsScheduler::Chromosome.new(@chromosome[0...@index1] +
                                                         @chromosome[@index1..@index2].reverse + @chromosome[@index2+1..-1])).should == true
          end
        end

        describe 'class method: point_mutation' do
          it 'should return a new chromosome with proper mutation, given a chromosome' do
            @index = rand(@length)
            @mutant = MeetingsScheduler::Chromosome.point_mutation(@chromosome, @index)
            @mutant.class.should == MeetingsScheduler::Chromosome
            @factors_to_consider[:attending_admits].keys.include?(@mutant[@index]).should == true
            (@mutant[0...@index]+@mutant[@index+1..-1]).should == @chromosome[0...@index]+@chromosome[@index+1..-1]
          end
        end

        describe 'class method: ok_to_mutate' do
          it 'should return false if a chromosome\'s normalized fitness is good enough' do
            @normalized_fitness, @random = rand, rand
            @chromosome.normalized_fitness = @normalized_fitness
            MeetingsScheduler::Chromosome.stub!(:random).and_return @random
            MeetingsScheduler::Chromosome.ok_to_mutate(@chromosome).should == (@random < ((1 - @chromosome.normalized_fitness) * 0.3)) ? true : false
          end
        end
      end

      describe 'class method: random' do
        it 'should choose random number between 0 and 1, exclusive' do  (0...1).include?(MeetingsScheduler::Chromosome.random).should == true end
        it 'should take parameter and return an integer' do
          r = MeetingsScheduler::Chromosome.random(100)
          (0...100).include?(r).should == true
          r.integer?.should == true
        end    
      end  

      describe 'class method: pick_two_random_indexes' do
        before(:each) do
          @length = rand(100)
          @chromosome = mock('MeetingsScheduler::Chromosome', :length => @length)
          @index1, @index2 = MeetingsScheduler::Chromosome.pick_two_random_indexes(@chromosome)
        end
        it 'should have the second integer be larger than the first' do @index2.should > @index1+1 end
        it 'should be integers in the proper range' do
          @index1.should > 0
          @index1.should < @length-3
          @index2.should > 2
          @index2.should < @length-1
        end      
      end
    end


    #describe MeetingsScheduler::Nucleotide do
    #  describe 'Nucleotide attributes' do
    #    before(:each) do
    #      @nucleotide = MeetingsScheduler::Nucleotide.new([1,2,3])
    #    end      
    #    it 'has a faculty_id' do @nucleotide.should respond_to(:faculty_id) end
    #    it 'has a schedule_index' do @nucleotide.should respond_to(:schedule_index) end
    #    it 'has an admit_id' do @nucleotide.should respond_to(:admit_id) end
    #    it 'is comparable to another nucleotide' do @nucleotide.==(MeetingsScheduler::Nucleotide.new([1,2,3])).should == true end
    #  end
    #end
  end
end

## Helper Methods to set up valid factors_to_consider and fitness_scores_table hashes

def create_valid_factors_hash
  double_crossover_probability = rand
  chromosomal_inversion_probability = rand
  point_mutation_probability = rand
  while chromosomal_inversion_probability + point_mutation_probability > 1
    point_mutation_probability = rand
  end

  faculties = 3.times.collect{ |id| create_valid_faculty_hash(id+100) }
  attending_admits = 4.times.collect{ |id| create_valid_admit_hash(id) }  
  faculties = {
    faculties[0][:id] => faculties[0],
    faculties[1][:id] => faculties[1],
    faculties[2][:id] => faculties[2]
  }  
  attending_admits = {
    attending_admits[0][:id] => attending_admits,
    attending_admits[1][:id] => attending_admits,
    attending_admits[2][:id] => attending_admits,
    attending_admits[3][:id] => attending_admits
  }
  
  lowest_rank_possible = 5
  total_number_of_seats = faculties.collect do |faculty_id, faculty|
    faculty[:schedule].collect{ |room_timeslot_pair| faculty[:max_students_per_meeting].times.collect }
  end
  total_number_of_seats = total_number_of_seats.flatten.count
  total_number_of_meetings = faculties.collect{ |faculty_id, faculty| faculty[:schedule].count }.inject(:+)
  number_of_spots_per_admit = (total_number_of_meetings / attending_admits.length).floor - 1
  
  return {
    :total_number_of_seats             => total_number_of_seats,
    :number_of_spots_per_admit         => number_of_spots_per_admit,
    :chromosomal_inversion_probability => chromosomal_inversion_probability,
    :point_mutation_probability        => point_mutation_probability,
    :double_crossover_probability      => double_crossover_probability,
    :lowest_rank_possible              => lowest_rank_possible,
    :attending_admits                  => attending_admits,
    :faculties                         => faculties
  }
end

def create_valid_faculty_hash(id)
  {
    :id                       => id,
    :max_students_per_meeting => rand(4)+1,
    :admit_rankings           => [],
    :schedule                 => [{:room => 'room1', :timeslot => 1.hour.from_now..5.hours.from_now},
                                  {:room => 'room2', :timeslot => 32.hours.from_now..45.hours.from_now}]
  }
end

def create_valid_admit_hash(id)
  {
    :id              => id,
    :name            => "Admit<#{id}>",
    :ranking         => [],
    :available_times => RangeSet.new([1.day.from_now..2.days.from_now,
                                      3.days.from_now..4.days.from_now])

  }
end

def create_valid_fitness_scores_table
  return {
    :meeting_possible_score       => rand(100),
    :meeting_possible_penalty     => -rand(100),
    :faculty_ranking_weight_score => rand(100),
    :faculty_ranking_default      => rand(100),
    :admit_ranking_weight_score   => rand(100),
    :admit_ranking_default        => rand(100),
    :area_match_score             => rand(100),
    :area_match_default           => rand(100),
    :one_on_one_score             => rand(100),
    :one_on_one_penalty           => -rand(100),
    :one_on_one_default           => rand(100),
    :mandatory_score              => rand(100),
    :mandatory_default            => rand(100)
  }
end
