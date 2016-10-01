using System;
using System.Collections.Generic;
using UnityEngine;

namespace Assets.Scripts.Cam.Effects {
	[Serializable]
	public class PaletteGrading {
		public int size = 6;

		[Range(0f, .5f)]
		public float blending = 0.25f;
		public Color c1 = Color.white;
		public Color c2 = Color.black;

		[HideInInspector] public Color c1B, c2B;
	}

	public class RetroPixelPalette : RetroPixelMax {
		public List<PaletteGrading> gradings = new List<PaletteGrading>();

		public void BlendStops() {
			for (int i = 0; i < gradings.Count; i++) {
				PaletteGrading pgA = i == 0 ? null : gradings[i - 1]; // before
				PaletteGrading pgB = gradings[i]; // current
				PaletteGrading pgC = i == gradings.Count - 1 ? null : gradings[i + 1]; // after

				if (pgA != null)
					pgB.c1B = Color.Lerp(pgA.c2, pgB.c1, 1f - pgB.blending);
				else
					pgB.c1B = pgB.c1;

				if (pgC != null)
					pgB.c2B = Color.Lerp(pgB.c2, pgC.c1, pgB.blending);
				else
					pgB.c2B = pgB.c2;
			}
		}

		public new void OnRenderImage(RenderTexture src, RenderTexture dest) {
			BlendStops();

			int s = 0;
			foreach (PaletteGrading pg in gradings)
				s += pg.size;

			colors = new Color[s];
			int i = 0;

			foreach (PaletteGrading pg in gradings) {
				for (int j = 0; j < pg.size; j++, i++) {
//					colors[i] = Color.Lerp(pg.c1, pg.c2, (float) j / pg.size);
					colors[i] = Color.Lerp(pg.c1B, pg.c2B, (float) j/pg.size);
				}
			}
			base.OnRenderImage(src, dest);
		}
	}
}