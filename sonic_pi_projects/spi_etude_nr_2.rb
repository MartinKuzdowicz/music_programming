# Martin Kuzdowicz sonic_pi etude nr 2

with_fx :reverb do

  # background
  in_thread do
    24.times do
      with_fx :flanger do
        sample :guit_em9, rate: 0.5
        sleep 4
      end
    end
  end

  in_thread do
    16.times do
      sample :guit_em9, rate: 2, amp: rand
      sleep 4
    end
  end

  in_thread do
    14.times do
      sample :bd_fat, amp: 6
      sample :bass_hit_c, rpitch: 4, release: 3
      sleep 2.75
      sample :bd_fat, amp: 6
      sample :bass_hit_c, rpitch: 4, release: 1
      sleep 1
      sample :bd_fat, amp: 6
      sample :bass_hit_c, rpitch: 4, release: 3
      sleep 0.25
    end
  end

  # random intor
  in_thread do
    sleep 8
    16.times do
      play choose([:b, :d, :fs, :a, :cs5]), amp: rrand(1, 4)
      sleep choose([1,2,0.5,4,0.25])
    end
  end

  # bridge
  with_fx :echo, phase: 0.5, mix: 0.20 do
    in_thread do
      sleep 40
      4.times do
        sleep choose([1, 0.5])
        play_pattern_timed scale(:b4, :minor_pentatonic), 0.5, release: 0.6, attack: 0.08, amp: 0.5
        sleep choose([1, 2])
      end
    end
    in_thread do
      sleep 40
      4.times do
        sleep choose([1, 0.5])
        play_pattern_timed scale(:d5, :major_pentatonic), 0.5, release: 0.6, attack: 0.08, amp: 0.5
        sleep choose([1, 2])
      end
    end

    # -------------------------------------------------------------------------------------------------------
    define :coda do |volume|
      play :fs5, attack: 0.5, sustain: 1.6, release: 0.2, amp: volume
      sleep 2
      play :b5, attack: 0.5, sustain: 1.6, release: 0.2, amp: volume
      sleep 2
      play :a5, attack: 0.5, sustain: 1.5, release: 0.25, amp: volume
      sleep 2
      play :g5, attack: 0.5, sustain: 1.4, release: 0.2, amp: volume
      sleep 2
      play :fs5, attack: 0.5, sustain: 1.6, release: 0.2, amp: volume
      sleep 2
      play :b5, attack: 0.5, sustain: 1.6, release: 0.2, amp: volume
      sleep 2
      play :cs6, attack: 0.5, sustain: 2, release: 0.2, amp: volume
      sleep 2
      play :d6, attack: 0.5, sustain: 2, release: 0.2, amp: volume
      sleep 2
    end

    # coda theeme
    in_thread do
      sleep 56
      use_synth :hoover
      2.times do
        coda 0.4
      end
    end

    # perc loop coda
    in_thread do
      sleep 56
      8.times do
        sample :loop_amen, rate: 0.4399, amp: 2
        sleep sample_duration :loop_amen, rate: 0.4399
      end
    end

    # bass for coda
    in_thread do
      sleep 56
      4.times do
        sample :bass_trance_c, rpitch: -8, amp: 2
        sleep 2 * (sample_duration :loop_amen, rate: 0.4399)
      end
    end

  end
end