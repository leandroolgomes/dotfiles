use crate::opts::Command::Transpile;
use crate::opts::Opts;
use crate::transpile;
use anyhow::Error;

pub fn handle(opts: Opts) -> Result<(), Error> {
    match opts.cmd {
        Transpile { filename } => transpile::main(&filename),
    }
}
