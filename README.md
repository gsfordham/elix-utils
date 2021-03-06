# ElixUtils

# DESCRIPTION
Elixir library to extract system information on GNU+Linux systems -- basically, gonna try to make a version of ``psutil`` for Elixir ⚗🐧

🚩 _I will not likely make this available on Windows, Mac, or \*BSD, but you can feel free to port it and make any necessary changes for your system, if you need it⭐_

⭐ I do not foresee \*BSD being a difficult port. Possibly not even Mac. Probably only minor changes, since both are also Unix/Unix-like.

⭐ I will not even begin to try to make this work on Windows, though. God speed and good luck, if _you_ wanna have a whack at it! 👍

# TODO
1) ~~System clock and date (soon)~~ *DONE*
1) ~~Motherboard information (soon)~~ *DONE*
1) CPU information (soon)
1) System/OS information (soon)
1) ~~Process count (probably soon-ish)~~ *DONE* -- See ℹ
1) Memory information (later)
1) GPU information⭐⭐ (more towards the end)
1) Disk information (more towards the end)
1) _Remove redundant code, refactor, optimize (as I go, always)_

⭐⭐Definitely AMD, but since I don't use NVIDIA or Intel, I will not likely do it for those systems -- however, feel free to do so, yourself

⭐⭐There is also a good chance this may be an extended library or a completely separate one to be built into other programs, at the individual programmer's discretion

⭐⭐After I finish the stuff I intend for this library, I will be remaking my own system monitor/control app, and I will link it here, so others can either copy it directly or adjust it for their personal needs -- this will let people see how to use the GPU monitor/controller, as well.

ℹI originally labeled this as "Process monitor", but I'm not 100% sure what else I might do with it. I meant to label it "Process count". However, now that I noticed this, I might actually think of further things to check. Not sure, though, so don't count on it any time soon.

# Possible things to add
1) Something related to hardware devices
1) Sound information and control (ALSA) -- Ideally I will, though
1) Network information

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `elix_utils` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:elix_utils, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/elix_utils](https://hexdocs.pm/elix_utils).

