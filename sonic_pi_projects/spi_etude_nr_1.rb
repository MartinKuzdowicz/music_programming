#Martin Kuzdowicz sonic_pi etude nr 1
# functions -----------------------------

define :verseOneTime do |panVal|
  2.times do
    play :c5, pan: panVal
    sleep 0.25
    play :eb, pan: panVal
    sleep 0.25
    play :g, pan: panVal
    sleep 0.25
    play :c5, pan: panVal
    sleep 0.25
    play :eb, pan: panVal
    sleep 0.25
    play :g, pan: panVal
    sleep 0.25
    play :c5, pan: panVal
    sleep 0.25
    play :eb, pan: panVal
    sleep 0.25
  end
  2.times do
    play :d, pan: panVal
    sleep 0.25
    play :f, pan: panVal
    sleep 0.25
    play :a, pan: panVal
    sleep 0.25
    play :d, pan: panVal
    sleep 0.25
    play :f, pan: panVal
    sleep 0.25
    play :a, pan: panVal
    sleep 0.25
    play :d, pan: panVal
    sleep 0.25
    play :f, pan: panVal
    sleep 0.25
  end
end

# ------------------------------------------

# verse 4 bars
define :verseFourTimes do |panVal|
  4.times do
    verseOneTime panVal
  end
end

# ------------------------------------------

# main theme
define :mainTheme do
  use_synth :pulse
  2.times do
    play :d5, release: 2, attack: 0.2
    sleep 1
    play :eb5, release: 2, attack: 0.3
    sleep 1
    play :bb5, release: 2, attack: 0.5
    sleep 1
    play :a5, release: 2, attack: 0.2
    sleep 1
    play :d5, release: 3, attack: 0.1
    play :g5, release: 2, attack: 0.1
    sleep 1
    play :c5, release: 3, attack: 0.1
    play :a5, release: 35, attack: 0.1
    sleep 1
    sleep 2
  end
  with_fx :echo do
    use_synth :saw
    2.times do
      play :d6
      sleep 0.5
      play :bb6
      sleep 0.5
      play :c6
      sleep 0.5
      play :a6
      sleep 0.5
      play :bb6
      sleep 0.5
      play :g6
      sleep 0.5
      play :a6
      sleep 0.5
      play :f6
      sleep 0.5

      play :d6
      sleep 0.5
      play :bb6
      sleep 0.5
      play :c6
      sleep 0.5
      play :a6
      sleep 0.5

      play :bb6
      sleep 0.25
      play :a6
      sleep 0.25
      play :g6
      sleep 0.25
      play :f6
      sleep 0.25
      play :a6
      sleep 0.25
      play :g6
      sleep 0.25
      play :f6
      sleep 0.25
      play :eb6, release: 4
      sleep 0.25
    end
  end
end

# ------------------------------------------

# Main Threads ----------------------------------

with_fx :reverb do

  # background thread
  in_thread(name: :backgr_left) do
    sleep 4

    verseOneTime -1
    verseOneTime -1

    verseFourTimes -1
    verseFourTimes -1

    verseFourTimes -1

  end
  in_thread(name: :backgr_right) do
    sleep 4

    verseOneTime 1
    verseOneTime 1

    verseFourTimes 1
    verseFourTimes 1

    verseFourTimes 1

  end

  # base thread
  in_thread do
    sleep 4
    8.times do
      with_fx :reverb do
        sample :bass_thick_c
        sleep 4
        sample :bass_thick_c, rpitch: 2, release: 1
        sleep 4
        sample :bass_thick_c, rpitch: 3, release: 1
        sleep 4
        sample :bass_thick_c, rpitch: 5, release: 2
        sleep 4
      end
    end
  end

  # main melody thread
  in_thread(name: :mainTheme) do
    sleep 4

    sleep 16
    mainTheme
    sleep 16
    mainTheme
  end
end

# drums loop
in_thread do
  with_fx :reverb, mix: 0.7 do
    sample :drum_cymbal_closed
    sleep 1
    sample :drum_cymbal_closed
    sleep 1
    sample :drum_cymbal_closed
    sleep 1
    sample :drum_cymbal_soft
    sleep 1
    16.times do
      sample :drum_heavy_kick
      sleep 4
      sleep 1
      sample :drum_tom_mid_hard
      sleep 1
      sample :drum_snare_hard, amp: 0.5, release: 2
      sample :drum_cymbal_open, attack: 0.01, sustain: 1, release: 1, amp: 0.5
      sleep 1
      sleep 1
    end
  end
end

# ------------------------------------------