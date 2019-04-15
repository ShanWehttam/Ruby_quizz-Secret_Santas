#!/usr/bin/env ruby

$stdout.sync = true

class SecretSantas
  attr_reader :givers, :receivers, :santas

  SIRNAME_MATCH = -> (x) { x.keys[0].split(" ")[1] == x.values[0].split(" ")[1] }
  SELF_OR_FAMILY = -> (x) { x == false }

  def initialize(santas)
    @santas = santas.map { |(name, email)| "#{name} #{email}" }
  end

  def givers
    @santas.shuffle
  end

  def receivers
    self.givers.shuffle
  end
  
  def remove_family_members
    loop { @pairs = givers.zip(receivers).map {|*pairs| pairs.to_h}
           break if @pairs.map(&SIRNAME_MATCH).all?(&SELF_OR_FAMILY) }
    @pairs
  end

end

xmas = SecretSantas.new([
    ["Luke Skywalker", "<luke@theforce.net>"         ],
    ["Leia Skywalker", "<leia@therebellion.org>"     ],
    ["Toula Portokalos", "<toula@manhunter.org>"     ],
    ["Gus Portokalos", "<gus@weareallfruit.net>"     ],
    ["Bruce Wayne", "<bruce@imbatman.com>"           ],
    ["Virgil Brigman", "<virgil@rigworkersunion.org>"],
    ["Lindsey Brigman", "<lindsey@iseealiens.net>"   ]
  ])

xmas.santas
xmas.givers
xmas.receivers
puts xmas.remove_family_members
