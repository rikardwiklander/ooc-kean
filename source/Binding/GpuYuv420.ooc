//
// Copyright (c) 2011-2014 Simon Mika <simon@mika.se>
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.
use ooc-math
import GpuMonochrome, GpuCanvas, GpuPlanar

GpuYuv420: class extends GpuPlanar {
  _canvas: GpuCanvasYuv420
  _y: GpuMonochrome
  y: GpuMonochrome { get { this _y } }
  _u: GpuMonochrome
  u: GpuMonochrome { get { this _u } }
  _v: GpuMonochrome
  v: GpuMonochrome { get { this _v } }
  canvas: GpuCanvasYuv420 {
    get {
      if (this _canvas == null)
        this _canvas = GpuCanvasYuv420 create(this)
      this _canvas
    }
  }
  init: func (=size)
  dispose: func {
    this _y dispose()
    this _u dispose()
    this _v dispose()
  }
  bind: func {
    this _y bind(0)
    this _u bind(1)
    this _v bind(2)
  }
  _generate: func (y: Pointer, u: Pointer, v: Pointer) -> Bool {
    this _y = GpuMonochrome create(this size, y)
    this _u = GpuMonochrome create(this size / 2, u)
    this _v = GpuMonochrome create(this size / 2, v)
    this _y != null && this _u != null && this _v != null
  }
  create: func (size: IntSize2D) -> This {
    result := This new(size)
    result _generate(null, null, null) ? result : null
  }
  create: static func ~fromPixels (size: IntSize2D, y: Pointer, u: Pointer, v: Pointer) -> This {
    result := This new(size)
    result _generate(y, u, v) ? result : null
  }
}
