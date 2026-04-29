import { readFile } from "node:fs/promises";

(async () => {
  /** @type {string} */
  const wasm = "./ms2hms.wasm";

  const pbytes = readFile(wasm);
  const pwasm = pbytes.then(WebAssembly.instantiate);

  const { module, instance } = await pwasm;
  const { exports } = instance;
  const { ms2hms } = exports;

  const imax = 86400 * 1000 - 1;
  let okcnt = 0;
  for (let i=0; i<imax; i++){
    const [ h, m, s, ms ] = ms2hms(i);

    const hours = (i / 3600 / 1000) | 0; // | 0 to convert to int
    const minutes = ((i % 3600000) / 60000) | 0;
    const seconds = ((i % 60000) / 1000) | 0;
    const millis = i % 1000;

    const ok = [
      hours === h,
      minutes === m,
      seconds === s,
      millis === ms,
    ].every(b => b);

    okcnt += ok ? 1 : 0;
  }

  console.info({
    imax,
    okcnt,
  });

})();
