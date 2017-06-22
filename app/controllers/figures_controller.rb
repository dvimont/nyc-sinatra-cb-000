class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'/figures/new'
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])
    self.save_new_children(params)
    redirect to "figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :'/figures/show'
  end

  get '/figures/:id/edit' do
    @landmarks = Landmark.all
    @titles = Title.all
    @figure = Figure.find_by_id(params[:id])
    erb :'/figures/edit'
  end

  post '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    @figure.update(params[:figure])
    self.save_new_children(params)
    redirect to "figures/#{@figure.id}"
  end

  def save_new_children(params)
    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
      @figure.save
    end
    if !params[:title][:name].empty?
      @figure.titles << Title.create(params[:title])
      @figure.save
    end
  end
end
