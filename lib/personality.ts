export type Vec = [number, number, number, number, number, number];
export const sumVecs = (arr: Vec[]): Vec =>
  arr.reduce((acc, v) => acc.map((x, i) => x + v[i]) as Vec, [0, 0, 0, 0, 0, 0]);
