using System;
using UnityEngine;

namespace Assets.Scripts.Cam.Effects {
	[ExecuteInEditMode]
	[RequireComponent(typeof(UnityEngine.Camera))]
	[AddComponentMenu("Image Effects/Custom/Retro Size")]
	public class RetroSize : MonoBehaviour {
		[Header("Resolution")]
		public int horizontalResolution = 160;
		public int verticalResolution = 144;
//		public float ratioForce = 1f;

		public void OnRenderImage(RenderTexture src, RenderTexture dest) {
			horizontalResolution = Mathf.Clamp(horizontalResolution, 1, 2048);
			verticalResolution = Mathf.Clamp(verticalResolution, 1, 2048);

//			float w = Screen.currentResolution.width;
//			float h = Screen.currentResolution.height;
//
//			float rw = w / horizontalResolution;
//			float rh = h / verticalResolution;
//
//			float r = Math.Min(rw, rh) * ratioForce;
//
//			RenderTexture scaled = RenderTexture.GetTemporary((int) (horizontalResolution * r), (int) (verticalResolution * r));

			// For GBJam, you probably don't want the above
			// + I don't think it's even working properly, I never really tested it
			// It was meant to keep the downsampling consistent no matter what was the window size
			// so that if you put the game in fullscreen, it wouldn't be very pixelated, it would actually
			// give you more resolution by using some sort of ratio or w.e

			RenderTexture scaled = RenderTexture.GetTemporary(horizontalResolution, verticalResolution);
			scaled.filterMode = FilterMode.Point;
			Graphics.Blit(src, scaled);
			Graphics.Blit(scaled, dest);
			RenderTexture.ReleaseTemporary(scaled);
		}
	}
}