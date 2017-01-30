# Martin Kuzdowicz sonic_pi_blues_nr1

define :chorus8BarsIn68 do |firstNote, secondNote|

  in_thread do
    48.times do
      play (scale firstNote, :minor_pentatonic).tick, release: 0.1
      sleep 0.125
    end
  end

  in_thread do
    48.times do
      play (scale secondNote, :minor_pentatonic).tick, release: 0.1
      sleep 0.125
    end
  end
end

# ----------------------------------------------------------------

define :chorus4BarsIn68 do |firstNote, secondNote|

  in_thread do
    24.times do
      play (scale firstNote, :minor_pentatonic).tick, release: 0.1
      sleep 0.125
    end
  end

  in_thread do
    24.times do
      play (scale secondNote, :minor_pentatonic).tick, release: 0.1
      sleep 0.125
    end
  end
end

# ----------------------------------------------------------------

define :chorus2BarsIn68 do |firstNote, secondNote|

  in_thread do
    12.times do
      play (scale firstNote, :minor_pentatonic).tick, release: 0.1
      sleep 0.125
    end
  end

  in_thread do
    12.times do
      play (scale secondNote, :minor_pentatonic).tick, release: 0.1
      sleep 0.125
    end
  end
end

# ----------------------------------------------------------------

define :bluesLick do |sleepTimeInBeetwen|
  play :e5
  sleep sleepTimeInBeetwen
  play :g5
  sleep sleepTimeInBeetwen
  play :a5
  sleep sleepTimeInBeetwen
  play :as5
  sleep sleepTimeInBeetwen
  play :a5
  sleep sleepTimeInBeetwen
  play :g5
  sleep sleepTimeInBeetwen
  play :e5
  sleep sleepTimeInBeetwen
end

# ----------------------------------------------------------------
# main -----------------------------------------
# 18 time of firs chorus

with_fx :reverb do

  in_thread do
    4.times do
      chorus8BarsIn68 :b3, :e4
      sleep 6
      chorus4BarsIn68 :e3, :a4
      sleep 3
      chorus4BarsIn68 :b3, :e4
      sleep 3
      chorus2BarsIn68 :fs3, :b4
      sleep 1.5
      chorus2BarsIn68 :e3, :a4
      sleep 1.5
      chorus4BarsIn68 :b3, :e4
      sleep 3
    end
  end

  # melody
  in_thread do
    sleep 18
    loop do
      if one_in(6)
        play_pattern_timed scale(:e5, :minor_pentatonic, num_octaves: 3), 0.125, release: 0.1
        sleep 2
      else if
        one_in(6)
        bluesLick 0.5
      else
        play (chord :e6, :m9).choose, amp: rand, release: 1.5
        if one_in(4)
          sleep 0.5
        else
          sleep 0.25
        end
      end
    end
  end
end
end