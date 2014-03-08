/*
 Copyright (C) 2010-2014 Kristian Duske
 
 This file is part of TrenchBroom.
 
 TrenchBroom is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 TrenchBroom is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with TrenchBroom. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef __TrenchBroom__RenderView__
#define __TrenchBroom__RenderView__

#include "Hit.h"
#include "Renderer/GL.h"

#include <wx/glcanvas.h>

namespace TrenchBroom {
    namespace Renderer {
        class RenderContext;
    }

    namespace View {
        
        class RenderView : public wxGLCanvas {
        public:
            typedef std::vector<int> GLAttribs;
        private:
            wxGLContext* m_glContext;
            bool m_initialized;
        protected:
            RenderView(wxWindow* parent, const GLAttribs& attribs, const wxGLContext* sharedContext = NULL);
        public:
            virtual ~RenderView();
            
            void OnPaint(wxPaintEvent& event);
            void OnSize(wxSizeEvent& event);

            const wxGLContext* glContext() const;
        private:
            void bindEvents();

            void initializeGL();
            void updateViewport();
            void render();
        private:
            virtual void doInitializeGL();
            virtual void doUpdateViewport(int x, int y, int width, int height) = 0;
            virtual void doRender() = 0;
        };
    }
}

#endif /* defined(__TrenchBroom__RenderView__) */
